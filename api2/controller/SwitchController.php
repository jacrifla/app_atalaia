<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/SwitchModel.php';
require_once './model/MacModel.php';
require_once './model/UserModel.php';

class SwitchController
{
    
    public function createSwitch(Request $request, Response $response)
    {
        try {
            
            $data            = $request->bodyJson();
            $mac_address     = $data['mac_address'];
            $user            = UserModel::getUserByUUID($data['user_id']);
            $data['user_id'] = $user['id'];
            //$macAvailable    = MacModel::checkMacAddressAvailable($mac_address);
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
                }else {
                //if ($macAvailable){
                   
                    
                    $reslt = SwitchModel::createSwitch($data);
                    
                    if ($reslt) :
                       // MacModel::updateMacAddressRecord($mac_address);
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
                        
                    }
                    // else{
                    //     $response::json([
                    //         'status' => 'error',
                    //         'msg' => 'Invalid Mac Address'
                    //     ], 401);
                    // }
                    
                } catch (\Exception $e) {
                    $response::json([
                        'status' => 'error',
                        'msg' => $e->getMessage()
                    ], 500);
                }
    }
            
    public function updateSwitch(Request $request, Response $response)
    {
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


    public function deleteSwitch(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = SwitchModel::softDelete($data['mac_address']);
            
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

    public function toggleSwitch(Request $request, Response $response)
    {
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

    public function getSwitches(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $userId = $data['user_id'];
            
            $switches = SwitchModel::getSwitches($userId);
            
            if ($switches) {
                return $response::json([
                    'status' => 'success',
                    'data' => $switches
                ], 200);
            } else {
                return $response::json([
                    'status' => 'error',
                    'message' => 'Nenhum ponto encontrado para o usuário',
                ], 404);
            }
        } catch (\Exception $e) {
            return $response::json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getSwitch(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $data = SwitchModel::getSwitch($data['mac_address']);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Ponto não encontrado'
                ], 404);
            }
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }
}
        