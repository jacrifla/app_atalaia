<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/RegisterModel.php';
require_once './model/UserModel.php';
require_once './model/GuardModel.php';

class RegisterController
{
    public function createUser(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            $hasUser = UserModel::checkUserExists($data);

            if($hasUser){
                $response::json([
                    'status' => 'error',
                    'msg' => 'Usuário existente'
                ], 409);
            }else{
                $user = RegisterModel::insert($data);
                
                if ($user) {     
                    GuardModel::createGuard($user);
                    unset($data['password_hash']); // Não envie o hash da senha de volta
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
                
            }
                
            
            } catch (\Exception $e) {
                $response::json([
                    'status' => 'error',
                    'msg' => $e->getMessage()
                ], 500);
            }
        }
        
        
        
    }
    