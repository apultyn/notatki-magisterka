<?php
if ($argc !== 3) {
    fwrite(STDERR, "Uzycie: php dopisz.php <plik> <linijka>\n");
    exit(1);
}

[, $plik, $linia] = $argv;
file_put_contents($plik, $linia . PHP_EOL, FILE_APPEND | LOCK_EX);