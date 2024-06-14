<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/GuardModel.php';
require_once './model/UserModel.php';

class GuardController
{
    // Obtém uuid dos grupos de um usuário.
    public function getGuardInfo(Request $request, Response $response)
    {
        try {
            
            $data            = $request->bodyJson();
            $user            = UserModel::getUserByUUID($data['user_id']);
            $data['user_id'] = $user['id'];
            $data            = GuardModel::getSwitches($data['user_id']);

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

    // Obtém todas as informações de um grupo.
    public function defineSwitch(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            
            $data = GuardModel::defineSwitch($data['mac_address'], $data['is_active']);
            
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

   
    // Alterna a ativação de um grupo e seus switches associados.
    public function toggleGuard(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            $toggle = GuardModel::toggleGuard($data['guard_id']);
            
            if ($toggle) {
                $response::json([
                    'status' => 'success',
                    'dados' => $toggle
                ], 200);
            } else {
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