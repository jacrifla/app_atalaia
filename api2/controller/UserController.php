<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/LoginModel.php';
require_once './model/RegisterModel.php';

class UserController
{
    
    public function login(Request $request, Response $response)
    {
        try {

             // // Verificar se os dados da requisição estão preenchidos corretamente usando o middleware EX
            // AINDA EM IMPLEMENTAÇÃO
            // $validationMiddleware = new Validations();
            // $validationResult = $validationMiddleware($request, $response, function ($request, $response) {
                // return $response;
            // });

            // // Se houver erros de validação, retornar a resposta com os erros
            // if ($validationResult->getStatusCode() !== 200) {
            //     return $validationResult;
            // }

            $data = $request->body();
            $data = LoginModel::login($data);

            if ($data) :
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            else :
                $response::json([
                    'status' => 'error',
                    'msg' => 'Not found'
                ], 404);
            endif;
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }


    public function createUser(Request $request, Response $response)
    {
        try {

            // // Verificar se os dados da requisição estão preenchidos corretamente usando o middleware EX
            // AINDA EM IMPLEMENTAÇÃO
            // $validationMiddleware = new Validations();
            // $validationResult = $validationMiddleware($request, $response, function ($request, $response) {
                // return $response;
            // });

            // // Se houver erros de validação, retornar a resposta com os erros
            // if ($validationResult->getStatusCode() !== 200) {
            //     return $validationResult;
            // }
            $data = $request->body();

            $success = RegisterModel::insert($data);

            if ($success) :
               
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 201);
            else :
                $response::json([
                    'status' => 'error',
                    'msg' => 'Not found'
                ], 500);
            endif;
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

}
