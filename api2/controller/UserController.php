<?php
require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/UserModel.php';

class UserController
{
   
    // Método para atualizar informações do usuário
    public function updateUser(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = UserModel::updateUserInfo($data);
            
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

    // Método para excluir um usuário
    public function deleteUser(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = UserModel::softDelete($data['user_id']);
            
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

    // Método para obter informações de um usuário específico
    public function getUserInfo(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = UserModel::getUserInfo($data['user_id']);
            
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
    
    // Método para obter todos os usuários
    public function getAllUsers(Request $request, Response $response)
    {
        try {
            $users = UserModel::getAllUsers();
            if ($users) {
                $response::json([
                    'status' => 'success',
                    'dados' => $users
                ], 200);
            } else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'No users found'
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