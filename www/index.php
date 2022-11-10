<html>

<head>

    <title><?php echo gethostname(); ?> - KONSTA WORKSPACE</title>
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
    /* Style the buttons that are used to open and close the accordion panel */
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  text-align: left;
  border: none;
  outline: none;
  transition: 0.4s;
}

/* Add a background color to the button if it is clicked on (add the .active class with JS), and when you move the mouse over it (hover) */
.active, .accordion:hover {
  background-color: #ccc;
}

/* Style the accordion panel. Note: hidden by default */
.panelaa {
  padding: 0 18px;
  background-color: white;
  display: none;
  overflow: hidden;
}
    </style>

</head>

<body>
    <div class="container">
        <div class="starter-template">
            <div class="panel-group">
                <div class="panel panel-primary">
                    <div class="panel-heading" style="text-align: left;"><h4><i class="fas fa-info"></i>&emsp;&emsp;Host: <code><?php echo $_SERVER['SERVER_ADDR']; ?></code> | Container: <code><?php echo gethostname(); ?></code></h4></div>
                    <div class="panel-body">
                        <center><table border=0 style="width:100%">
                            <tr>
                                <td style="width:25%"><a href="rstudio"><center><img src="data:image/png;base64,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" style="height: 80px"><br />RStudio</center></a></td>
                                <td style="width:25%"><a href="e"><center><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAT4AAACfCAMAAABX0UX9AAAAwFBMVEX////zdyZOTk6Yl5hISEh2dndFRUVLS0tCQkI/Pz9HR0dvcHCIiIjc3NzPz89QUFD5+fni4uKioqJeXl68vLzzcxvu7u7w8PDo6OjybQBjY2NVVVXDw8PV1dXzcRXLy8utra05OTn+8+5+fn7959r+8+xoaWn0gDbzeyv72seysrKbm5uNjY35wqT2mGH4r4X707z1klb6yq/0hD73pXX849T5upf1i0n4tI73oGr1kFj97uP5xKv2m2vyZQAyMjJbEuNCAAALHElEQVR4nO2d6WKqvBaGFZAATiiioIjUAYc6tXXq9vTs+7+rbwUZAlqr1V2g5vnTMoXk7UqyEpLVTIZCoVAoFAqFQqFQKBQKhUKhUCgUCoVCoVAoFMr9kBtx5yC9yEYhl+tZ9bjzkU7kaT4H5HvtuHOSRlz1MMW485JCDF+9XCHuvKSQgq9eLq/FnZnUUe8R8nXizk3q0Ej5jLhzkzoapHyluHOTROTuYLDf7weDrnzi6nPQdeSp8xxhMJ4tPrbDUVZVR8PtfLVZ7iN3FH358tVYshgrjUkvx552eAfj3VA3TVVVsy6qapq6+r7sk7cZtqsee8o4fzf1np3P23bt+Ep/sTXN7ClUc7haElIZvTyQqz5e1ZWndt4hOmBYvuintXMV1IezoBY3OhPLqPxszhNB0VXPfg6dft0GFfYzzNFmEFOuE4PhypfvESfHc/NL8RwB32axZTwZlJqufMFwdbDSLxIPo2/HMWY+fjRXPXvinVluz7V5UdTsYxvgxDE/u+f1mpvL6i1hgO/dWAsQMxa4LfbUnSoZzK8xPdcAR/3zb/jdVIxa23XiuldVXF+/4WM3gB79t5MVV3UwDz9OCmgu4856AtgfqQdDtNHwbftnvlotFovV6n3+B4a/WMnojVS/wVYNKafrw9Vsue6HfePufj3+32Kr6+EuZvTo9bf7YhLajea75dkedb35eCP9Qz06EfNgrExfO/XltX/B5Ml++Z71bVB9eWj/Zaa7Mujb2RWGtFx5szLm+7/LXOJZu+KNPsZXTtrtd28HAc0HHn+8qI7lrdbfeHawUR0B1Ydt/ja4/Obqu8OH7m4E8qvzu+YpPQyg8ObwFt+tj0d7j+r9Qa+r727sOWdggKP7ZCdlrLPq2+2Gs38xk9J7/OxSuXd9e49JE3mlbxPg/GmTQusnP/n19Y87pfT6//jNr/QkcOJPyrdb3e1ts+29Uvo2bY5hflK+7uqOic1i73x/Wr79Xdur2Geef1q+X8bvlq8OeIVraABxTSaPtUpFc27UjCrLWp3AGZHJNMKpalrdQAwjVHBKGnlPpWM9Vyel0DqSuvu6RseqpmNZdsVuNpvegiSrpSh54qIBxy3vIN9SmhUQhFV4XpJ4SfGX0LRbzaYyIZ7L1BQ4A0rIkIDCMAxSMK1gsWa70IJUeAE1LULAgqI04a9iNCX+ybpvOf8RRQYh5C2irAqIU4iLNREh0TuwOVRuZ9plHh5AWBLBdi1EbnJIImXP5CQ4AbYmi4d78UsgKX/dEytwCHEShyCVZmDvPXhMw7kAew39ORJLsQyF8+XjwU6IizUBmi3vIA+FahtQbKHcVBCPNZHcVUiWxDBlYk1dpYUYCWsl/xUECcsnYP668sk9gUG8XZhObQkxXMtfy1TgGL5uQNKIE3+hfOVJC0lKDRqyYpUHNTn7UPM06B14YilmDRTgnLaxZhhVuJGHn4ZRc+2sIIE+Br7eMMogdM9rE6ccIxSbCN7Ry51YoZdALpcvxzFlqGueSsUmaCaw/jXEBM/ZYFP+Eien5yVfWRPhLZ7FVeBB3pNqKjEcy0t2enZDXS5fD2RgpMDGcA1FbsXrgLmJ/jL0hgj25m+JiDoujSYIFgg0Id7J4orO9VK0qvM6+VCe0GECheUt59cG2JvEEo8h29cgKh8YnzQNDuug5pNri89YPiFNW3kul6+AZQjtE4GCI5t40i23DEITLWFUPmhDEVk7weTcP0KmKoXsOwVcJx8fco6xsQiHMxrUV8HVVoNaLQYrgyPywdXQOzIW71tjFffn6Wn4MlfKh0LOXaYNmomu7wcWx+X9p8gbI/J1wPhyciMAGj8uJwfvT9Uu5Kvk43qhZzUmMDkDRCofTC7vOn0uEflwmmWFoIWb1Ib//ub9yvYDXCdfeIMrrqWCK1RDAdEcV1cD96ZFNP8R+SzeG4R4hOWz71i4f88t8tWVQL7MMy46Vgk65NB9Eflw+4aEMCJRecPtQ9K52fq8vriC+xFce6EVFMh9sMfycT2tEkYL3v848mHFRK+jdNyVZ6jF0HE0Scc3It9EiDahASmXD9ol1CIuTs73vAa+7Ctl8I5XDZKHXbeIfIb0efeQcvmcXpFo9bEbG5KvFXoWhqiEscp42qWIbxNCU50R+drl8DtIUi5fB0rKEe1WE0+8eQfOqIP0aRvQ9JHzLNB5CBb0wBHjaiPSRp35BMk6nZmUy1cEH0wKNtNhNRneO8LyhRo/bJvkGKENXardloIJFDdRxu1TvMdwC3HaN065fNgyGOQVVVPwRHFo0EY2ayVQj8sRSck5jpEKnD/2dcEzM6SiuL/mTm9zT7t8loDnQA9NV0fhWmCNT941LB9CvPeFo1aG0Vc51MrhppOceTmAZ2OQTUhag7Ee12r7zaHmW3Da5cOWAUVjJzWrJyHRyqGQfMguI96utivFWgF/kIjMqMvOZw0x+o1sis00bxm1qqtYD8uMela7olVK1lRRPCXTJ187JF+mI+LqKwkCz4GhZbB8Xtmw3zftwCCLF0VRwKZ4NLeEp2COy1/BSiNeEBivxrL4LRxORxR55wvUgRTKx4S/8kzKzqcdKG4LTKvHoyevzAe3udSSkHuDchQkpgOXpOOPFBPEOY9wfodRU/jDKXyWL3udfVVAUrrGvCXkeGsBxSm2iieGxa3Vs51vhuXL1KvlJ3yDPTlu/Ut4+v5Ep1DKO48Ql+q1PI/PiU/l3sTvlic2uY85DRic/8HCp9IpnYiDEAzatFKpeHLVRXiamaTeLrWjumpw7nQ6N/Gj60FqeJh70beZ4zFvlKIQnqqKh/0915R9lRi09hdOsX0pn5z/1Ph+Evn9O5s5TjN4P79ATVaOHbVP+FK+KbQDXAKWUr1m77UdUt5+sbXDEMkPtGf5Sj7scidjZcpQf71LOus3/bwhT7DjkLvMYs7L1yjgb+PJ6DZnprq5QzLjoXlmjbncMHrYh7vQ+M7KJ3ds7EcrsfcbDt2tar7cuiFN3unZc8bH/nWGDhc39mfkk5vOMKKclLBPSz2rjm7bU7B+U7PquT2p+JPXqaHDZxQkRvrM+vDEIJ9PinqHDZXm/Ps9cHeBwxucjUhiPAliuXr5R+lzlbcqSGKSVvb0Dzuhv3A7PmOwcaKt6Wftt27V7rZ+uKiwyTE9zOawI3f0jT2p3c1hP7T68g/ydZrkRcifq+5e/I/rBiHrRdYLghD7lo4YGYz8oDfDxfqynTJyf7b1xVPv4zumlWUQVcQ0XxZfhzRYbz5GQTAXc/ETmUwwr3o4CM52t1yfDg/Z7Y9nczMUCMd81I34AZtw/C8cgentz2o3W6733QOD/vh1s5pvh2okTJ35kYCNvHGz07NRnEjDALh1KjZJJw7x0V3mY8fA8Zgd63cJ5pyq5zD7OmDuCfVWVD2X8fBq/cxd3JlOEPsrw2+qN4V/+X3Is8vjDsM4d/6wkZc+o/9xqQGadwj/8vuQl2+XhB82s7uHj7p+Gvl1+0UVVkE8Wm8DZDk8yl3CiPZzw1P/bKi3ElCpWVWrFt7f1Z+94UFG1Oxg8JG9dE7mMahXpyxm+hyZxB0sF/OhefiPMYfx2+hlcU1wzkdAq7I+R5Pg8qA/nu0WKxy6ebbs3zdozq+AUI9lEzcPnnQ6pHpsOmIiJAc5ZHzsc6o2uMZPfRqSb5qOcESJoRKWj6X/pvMqilS+W6CV9yYiXQdLu47rCDsuiViwmSbkZ2p8t1Ah1EtVVJiEUHebv2lKYlAmDbltgXrVTgLW+acVKh2FQqFQKBQKhUKhUCgUCoVCoVAoFAqFQqFQKJT/AJNe4mLcdCBmAAAAAElFTkSuQmCC" style="height: 80px"><br />Jupyter</center></a></td>
                                <td style="width:25%"><a href="vscode"><center><img src="data:image/png;base64,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" style="height: 80px"><br />VS Code</center></a></td>
                                <td style="width:25%"><a href="f"><center><img src="data:image/png;base64,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" style="height: 80px"><br />Files manager</a></td>
</tr></table></center>
                        
                    </div>
</div><p></p>

<div class="panel panel-primary"><div class="panel-body">
    <p style="text-align:right"><a href="wetty/ssh/root?pass=konrad" target="_blank"><i class="fas fa-terminal"></i> New window</a></p>
    <iframe src="wetty/ssh/root?pass=konrad" width="100%" height="500" frameBorder="0"></iframe>
    <p style="text-align:left">Useful: <code>top -d1</code>, <code>free -h</code>, <code>df -h</code></p>
    <p style="text-align:left">SSH connection for terminal & files (SCP, SFTP): <code>sshpass -p konrad ssh root@<?php echo $_SERVER['SERVER_ADDR']; ?></code></p>

<button class="accordion"><i class="fas fa-sticky-note"></i>&emsp;&emsp;Notes</button>
<div class="panelaa">
<p></p>
<iframe src="n.php" width="100%" height="500" frameBorder="0"></iframe>
</div>

</div></div>
<p></p>
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
                    <script>
                        var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}
                        </script>
                    <p></p>
                </div>
            </div>
        
    </div>

    <iframe src="/rstudio/auth-sign-in?appUri=%2F" width="0" height="0" tabindex="-1" title="empty" class="hidden"></iframe>
</body>

</html>