<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/MacModel.php';
//somente uso interno
class MacAddressController
{
    private function __construct()
    {
    }
    
    public function insert(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            $success = MacModel::insert($data['mac_address']);
                
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
            } catch (\Exception $e) {
                $response::json([
                    'status' => 'error',
                    'msg' => $e->getMessage()
                ], 500);
            }
        }
        
        
        
    }
    