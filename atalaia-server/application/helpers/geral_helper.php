<?php
defined('BASEPATH') or exit('No direct script access allowed');

   function checkParams($params, $listParams){
        foreach($listParams as $key => $value){
            if(array_key_exists($key, get_object_vars($params))){
                $status = 1;
            }else{
                $status = 0;
                break;
            }
        }

        if(count(get_object_vars($params)) != count($listParams)){
            $status = 0;
        }

        return $status;
   }

?>

