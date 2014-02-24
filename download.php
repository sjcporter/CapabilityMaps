<?php
    header("Content-Disposition: attachment; filename=\"graph.{$_GET['ext']}\"");
    echo $_POST['content'];
?>
