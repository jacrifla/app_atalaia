<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/GroupSwitchModel.php';
require_once './model/UserModel.php';

class GroupSwitchController
{
    
    public function createSwitch(Request $request, Response $response){
        try {
            
            $data            = $request->bodyJson();
            $mac_address     = $data['mac_address'];
            $macAvailable    = MacModel::checkMacAddressAvailable($mac_address);
            $switchExists    = SwitchModel::checkSwitchExists($data);
            
            
            if($switchExists){
                $data = SwitchModel::reactivateSwitch($data);
                
                if ($data) :
                    $response::json([
                        'status' => 'success',
                        'dados' => $data
                    ], 200);
                    else :
                        $response::json([
                            'status' => 'error',
                            'msg' => 'Internal Error'
                        ], 400);
                    endif;
                }else if ($macAvailable){
                    $user = UserModel::getUserByUUID($data['uuid']);
                    $data['user_id'] = $user['id'];
                    
                    $reslt = SwitchModel::createSwitch($data);
                    
                    if ($reslt) :
                        MacModel::updateMacAddressRecord($mac_address);
                        $response::json([
                            'status' => 'success',
                            'dados' => $reslt
                        ], 200);
                        else :
                            $response::json([
                                'status' => 'error',
                                'msg' => 'Internal Error'
                            ], 400);
                        endif;
                        
                    }else{
                        $response::json([
                            'status' => 'error',
                            'msg' => 'Invalid Mac Address'
                        ], 401);
                    }
                    
                } catch (\Exception $e) {
                    $response::json([
                        'status' => 'error',
                        'msg' => $e->getMessage()
                    ], 500);
                }
    }
            
    public function updateSwitch(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            
            $data = SwitchModel::updateSwitchInfo($data);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Internal Error'
                ], 400);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }


    public function deleteSwitch(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            
            $data = SwitchModel::softDelete($data['uuid']);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Internal Error'
                ], 400);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

    public function toggleSwitch(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            
            $data = SwitchModel::toggleSwitch($data);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Internal Error'
                ], 400);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

    public function getSwitches(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            //uuid do user
            $data = SwitchModel::getSwitches($data['user_id']);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Internal Error'
                ], 400);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }
    
        
        
}
        