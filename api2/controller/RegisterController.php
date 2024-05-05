<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/RegisterModel.php';
require_once './model/UserModel.php';

class RegisterController
{
    public function createUser(Request $request, Response $response)
    {
        try {
            $data = $request->body();
            
            $hasUser = UserModel::checkUserExists($data);

            if($hasUser){
                $response::json([
                    'status' => 'error',
                    'msg' => 'Existent User'
                ], 400);
            }else{
                $success = RegisterModel::insert($data);
                
                if ($success) {     
                                   
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
    