<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/PasswordModel.php';

class PasswordController
{
    public function reqChangePassword(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            $genToken = PasswordModel::generateToken($data['email']);
            PasswordModel::sendVerificationCode($data['email'], $genToken);
            
            
            
            if ($genToken) {     
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 201);
            }else{
                $response::json([
                    'status' => 'error',
                    'msg' => 'Unkwon error'
                ], 400);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }
    
    public function changePassword(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            $baseToken = PasswordModel::getTokenByEmail($data['email']);
            if($baseToken == $data['token']){
                $success = PasswordModel::changePassword($data);
            }else{
                $response::json([
                    'status' => 'error',
                    'msg' => 'Token Inválido'
                ], 400);
                
            }
            
            
            
            if ($success) {     
                PasswordModel::deleteTokenByEmail($data['email']);
                $response::json([
                    'status' => 'success'
                ], 201);
            }else{
                $response::json([
                    'status' => 'error',
                    'msg' => 'Unkwon error'
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
