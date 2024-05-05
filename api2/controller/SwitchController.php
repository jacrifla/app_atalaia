<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/SwitchModel.php';
require_once './model/MacModel.php';
require_once './model/UserModel.php';

class SwitchController
{
    
    public function createSwitch(Request $request, Response $response){
        try {
            
            $data            = $request->bodyJson();
            $macAvailable    = MacModel::checkMacAddressAvailable($data['mac_address']);
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
                    
                    $data = SwitchModel::createSwitch($data);
                    
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
        