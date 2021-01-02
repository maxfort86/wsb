<?php
error_reporting(0);

$timezone = 'America/New_York';
date_default_timezone_set($timezone);

$ticker = trim($_GET['ticker']);

if(strlen($ticker) > 0){

$contents = file_get_contents("https://query1.finance.yahoo.com/v7/finance/options/$ticker");
$contents = json_decode($contents, true);

//print_r($contents); die;

$expiration_dates = $contents['optionChain']['result'][0]['expirationDates'];
$current_price = ($contents['optionChain']['result'][0]['quote']['bid'] + $contents['optionChain']['result'][0]['quote']['ask']) / 2;
$name = $contents['optionChain']['result'][0]['quote']['shortName'];

//echo($current_price); die;

$options = [];

$dates_h20 = [];
$dates_h = [];
$dates_l = [];
$dates_l20 = [];

$strikes_c = [];
$strikes_p = [];

$dates_hl_ratio = [];
$dates_hl20_ratio = [];

foreach($expiration_dates as $ed){
    
    $contents = file_get_contents("https://query2.finance.yahoo.com/v7/finance/options/$ticker?date=$ed");
    $contents = json_decode($contents, true);
    
    $calls = $contents['optionChain']['result'][0]['options'][0]['calls'];
    foreach($calls as $c){
        $c['type'] = 'C';
        $options[] = $c;
        
        $strikes_c[ $c['strike'] ] += $c['openInterest'];
        
        if($c['strike'] > $current_price){
            $dates_h[ $c['expiration'] ] += $c['openInterest'];
        }
        
        if($c['strike'] > $current_price * 1.1){
            $dates_h20[ $c['expiration'] ] += $c['openInterest'];
        }
        
    }
    
    $puts = $contents['optionChain']['result'][0]['options'][0]['puts'];
    foreach($puts as $p){
        $p['type'] = 'P';
        $options[] = $p;
        
        $strikes_p[ $p['strike'] ] += $p['openInterest'];
    
        if($p['strike'] < $current_price){
            $dates_l[ $p['expiration'] ] += $p['openInterest'];
        }
        
        if($p['strike'] < $current_price * 0.9){
            $dates_l20[ $p['expiration'] ] += $p['openInterest'];
        }
    }
    
}

foreach($expiration_dates as $ed){
    $dates_hl_ratio[$ed] = $dates_h[$ed] - $dates_l[$ed];
    $dates_hl20_ratio[$ed] = $dates_h20[$ed] - $dates_l20[$ed];
}


function srt($a, $b){
    return $b['openInterest'] > $a['openInterest'];
}
usort($options, 'srt');

arsort($dates_h);
arsort($dates_h20);
arsort($dates_l);
arsort($dates_l20);
arsort($dates_hl_ratio);
arsort($dates_hl20_ratio);
arsort($strikes_c);
arsort($strikes_p);

//print_r($options); die;
}

?>
<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <title>Most Popular Options, Strike Prices, and Dates</title>
    </head>
    <body style="padding-top:10px;">
        <div class="container">
            <div class="row">
                <div class="col">
                    
                
            
        
        <h1>Most Popular Options, Strike Prices, and Dates</h1>
        
        <form method="GET" class="mt-3 row align-items-center">
        <div class="col-4 col-sm-3 col-md-2">
            <input class="form-control form-control-lg" type="text" name="ticker" value="<?=$ticker?>" placeholder="Ticker">
        </div>
        <div class="col-4 col-sm-3 col-md-2">
            <input type="submit" value="Submit" class="btn-primary btn-lg form-control">
        </div>
        </form>
        
        
        <?php if(strlen($ticker) > 0){ ?>
        <br>
        <p><strong><?=$name?></strong>, Current Price: <?=round($current_price,2)?></p>
        <br>
        <h2>Top 5 Options with the Highest Open Interests</h2>
        <table class="table table-sm table-striped" >
            <tr>
                <th>#</th>
                <th>Type</th>
                <th>Strike</th>
                <th>Expiration</th>
                <th>Premium</th>
                <th>Open Interest</th>
            </tr>
        <?php
        for($i = 0; $i < 5; $i++) { ?>
        <tr class="<?=$options[$i]['type']=='C' ? 'table-success' : 'table-danger'?>">
                <td><?=$i+1?></td>
                <td><?=$options[$i]['type']?></td>
                <td><?=$options[$i]['strike']?></td>
                <td><?=date("m/d/Y",$options[$i]['expiration'] + 18000)?></td>
                <td><?=round(($options[$i]['bid'] + $options[$i]['bid'])/2,2)?> (<?=round($options[$i]['percentChange'],2)?>%)</td>
                <td><?=$options[$i]['openInterest']?></td>
        </tr>
        <?php
        }
        ?>
        </table>
        
        <br>        
        <h2>Top 3 Popular Strike Prices for Calls (All Dates)</h2>
        <table class="table table-sm table-striped table-success" >
            <tr>
                <th>#</th>
                <th>Strike</th>
                <th>Open Interest</th>
            </tr>
        <?php
        $i = 0;
        foreach($strikes_c as $s=>$oi){
            ?>
        <tr>
                <td><?=$i+1?></td>
                <td><?=$s?></td>
                <td><?=$oi?></td>
        </tr>
        <?php
        if($i == 2){ break; }
        $i++;
        }
        ?>
        </table>
        
        <br>
        <h2>Top 3 Popular Strike Prices for Puts (All Dates)</h2>
        <table class="table table-sm table-striped table-danger" >
            <tr>
                <th>#</th>
                <th>Strike</th>
                <th>Open Interest</th>
            </tr>
        <?php
        $i = 0;
        foreach($strikes_p as $s=>$oi){
            ?>
        <tr>
                <td><?=$i+1?></td>
                <td><?=$s?></td>
                <td><?=$oi?></td>
        </tr>
        <?php
        if($i == 2){ break; }
        $i++;
        }
        ?>
        </table>
        
        <br>
        <h2>Most Bullish Dates</h2>
        <p>Most bullish days are defined as the days with the highest surplus of <abbr title="Strike at least 10% higher than current price">Deep OTM Calls</abbr> open interest to <abbr title="Strike at least 10% lower than current price">Deep ITM Puts</abbr> open interest.</p>
        <table class="table table-sm table-striped table-success" >
            <tr>
                <th>#</th>
                <th>Date</th>
                <th>Open Interest (OTM Calls - ITM Puts)</th>
            </tr>
        <?php
        $i = 0;
        foreach($dates_hl20_ratio as $d=>$oi){
            ?>
        <tr>
                <td><?=$i+1?></td>
                <td><?=date("m/d/Y",$d + 18000)?></td>
                <td><?=$oi?></td>
        </tr>
        <?php
        if($i == 2){ break; }
        $i++;
        }
        ?>
        </table>
        
        <br>
        <h2>Most Bearish Dates</h2>
        <p>Most bearish days are defined as the days with the highest surplus of <abbr title="Strike at least 10% lower than current price">Deep ITM Puts</abbr> open interest to <abbr title="Strike at least 10% higher than current price">Deep OTM Calls</abbr> open interest.</p>
        <table class="table table-sm table-striped table-danger" >
            <tr>
                <th>#</th>
                <th>Date</th>
                <th>Open Interest (ITM Puts - OTM Calls)</th>
            </tr>
        <?php
        asort($dates_hl20_ratio);
        $i = 0;
        foreach($dates_hl20_ratio as $d=>$oi){
            ?>
        <tr>
                <td><?=$i+1?></td>
                <td><?=date("m/d/Y",$d + 18000)?></td>
                <td><?=-1*$oi?></td>
        </tr>
        <?php
        if($i == 2){ break; }
        $i++;
        }
        ?>
        </table>
        
        <br>
        <p class="alert alert-info small">Did you find this tool useful? <a href="https://act.webull.com/pr/dnCyOULHUbvp/rmv/inviteUs/">Sign up on WeBull with my referral code</a>
        so we both get several free stonks!</p>
        
        
        
        <?php } ?>
        <br>
        <p class="small">Built by <a href="https://www.reddit.com/user/maxfort86">u/maxfort86</a> using Yahoo Finance data</p>
        
        </div>
            </div>
        </div>
    </body>
    
    
</html>