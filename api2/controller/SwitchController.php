<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/SwitchModel.php';
require_once './model/MacModel.php';

class SwitchController
{
    
    public function login(Request $request, Response $response)
    {
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

}
