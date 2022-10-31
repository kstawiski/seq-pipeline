<html>

<head>

    <title>KONSTA WORKSPACE</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
    <script src="jquery-ui.js" type="text/javascript"></script>
    <link rel="stylesheet" href="bootstrap.min.css" />
    <link rel="stylesheet" href="bootstrap-theme.min.css" crossorigin="anonymous" />
    <script src="bootstrap.min.js"></script>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="author" content="Konrad Stawiski (konrad.stawiski@umed.lodz.pl)" />
    <link rel="stylesheet" href="css/starter-template.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/js/all.min.js"></script>
    <style>
    iframe.hidden {
        display: none
    }
    </style>

</head>

<body>
    <div class="container">
        <div class="starter-template">
            <div class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading"><i class="fas fa-info"></i>Host: <code><?php echo $_SERVER['SERVER_ADDR']; ?></code> | Client: <code><?php echo gethostbyaddr($ip_adress); ?></code> | Container: <code><?php echo gethostname(); ?></code></div>
                    <div class="panel-body">
                        <ul>
                            <li><a href="rstudio">RStudio</a></li>
                            <li><a href="e">Jupyter</a></li>
                            <li><a href="vscode">VS Code</a></li>
                            <li><a href="f">Files manager</a></li>
                        </ul>
                    </div>


                    <script type="text/javascript" src="monitor/gauge/jquery-asPieProgress.js"></script>
                    <script type="text/javascript">
                    $(document).ready(function() {
                        // Example with grater loading time - loads longer
                        $('.pie_progress_temperature,.pie_progress_cpu, .pie_progress_mem, .pie_progress_disk')
                            .asPieProgress({});
                        getTemp();
                        getCpu();
                        getMem();
                        getDisk();
                    });

                    function getTemp() {
                        $.ajax({
                            url: 'monitor/temperature.json.php',
                            success: function(response) {
                                update('temperature', response);
                                setTimeout(function() {
                                    getTemp();
                                }, 1000);
                            }
                        });
                    }


                    function getCpu() {
                        $.ajax({
                            url: 'monitor/cpu.json.php',
                            success: function(response) {
                                update('cpu', response);
                                setTimeout(function() {
                                    getCpu();
                                }, 1000);
                            }
                        });
                    }

                    function getMem() {
                        $.ajax({
                            url: 'monitor/memory.json.php',
                            success: function(response) {
                                update('mem', response);

                                setTimeout(function() {
                                    getMem();
                                }, 1000);
                            }
                        });
                    }

                    function getDisk() {
                        $.ajax({
                            url: 'monitor/disk.json.php',
                            success: function(response) {
                                update('disk', response);
                                setTimeout(function() {
                                    getDisk();
                                }, 1000);
                            }
                        });
                    }

                    function update(name, response) {
                        $('.pie_progress_' + name).asPieProgress('go', response.percent);
                        $("#" + name + "Div div.title").text(response.title);
                        //$("#" + name + "Div pre").text(response.output.join('\n'));
                    }
                    </script>
                    <link rel="stylesheet" href="monitor/gauge/css/asPieProgress.css">
                    <p></p>
                    <div class="panel panel-default">
                        <div class="panel-heading"><i class="fas fa-heartbeat"></i>&emsp;&emsp;Resources (monitor)</div>
                        <div class="panel-body">
                            <div class="col-xs-3 col-sm-3 col-lg-3" id="cpuDiv">
                                <div class="pie_progress_cpu" role="progressbar" data-goal="33">
                                    <div class="pie_progress__number">0%</div>
                                    <div class="pie_progress__label">CPU</div>
                                </div>

                                <div class='title'></div>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-lg-3" id="memDiv">
                                <div class="pie_progress_mem" role="progressbar" data-goal="33">
                                    <div class="pie_progress__number">0%</div>
                                    <div class="pie_progress__label">Memory</div>
                                </div>

                                <div class='title'></div>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-lg-3" id="diskDiv">
                                <div class="pie_progress_disk" role="progressbar" data-goal="33">
                                    <div class="pie_progress__number">0%</div>
                                    <div class="pie_progress__label">Disk</div>
                                </div>

                                <div class='title'></div>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-lg-3" id="temperatureDiv">
                                <div class="pie_progress_temperature" role="progressbar" data-goal="33">
                                    <div class="pie_progress__number">0°</div>
                                    <div class="pie_progress__label">Temperature</div>
                                </div>
                                <div class='title' style="display:none;"></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <iframe src="/rstudio/auth-sign-in?appUri=%2F" width="0" height="0" tabindex="-1" title="empty" class="hidden">
</body>

</html>