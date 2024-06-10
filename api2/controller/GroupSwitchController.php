<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/GroupSwitchModel.php';
require_once './model/UserModel.php';

class GroupSwitchController
{
    // Obtém uuid dos grupos de um usuário.
    public function getGroups(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::getGroups($data['user_id']);
            
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
    public function getAllGroupInfo(Request $request, Response $response){
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::getAllGroupInfo($data['user_id']);
            
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

    // Obtém informações de um grupo específico.
    public function getOneGroup(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $group = GroupSwitchModel::getOneGroup($data['group_id']);
            
            if ($group) {
                $response::json([
                    'status' => 'success',
                    'dados' => $group
                ], 200);
            } else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Group not found'
                ], 404);
            }
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

    // Cria um novo grupo.
    public function createGroup(Request $request, Response $response)
    {
        try {
            
            $data            = $request->bodyJson();
            // $mac_address     = $data['mac_address'];
            $user            = UserModel::getUserByUUID($data['user_id']);
            $data['user_id'] = $user['id'];
            $group           = GroupSwitchModel::createGroup($data);

            if ($group) {
                $response::json([
                    'status' => 'success',
                    'dados' => $group
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

    // Atualiza as informações de um grupo.
    public function updateGroupInfo(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::updateGroupInfo($data);
            
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
    public function toggleGroup(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $groupInfo = GroupSwitchModel::getGroupIdByUUID($data['group_id']);
            $data['group_id'] = $groupInfo['id'];
            
            $toggle = GroupSwitchModel::toggleGroup($data);
            if ($toggle) {
                $switches = GroupSwitchModel::getSwitchesInGroup($data['group_id']);
                if ($switches) {
                    $toggle = GroupSwitchModel::toggleSwitches($data['group_id'], $data['is_active']);
                } else {
                    $toggle = 'Não há switches nesse grupo';
                }
            }
            
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

    // Adiciona um switch a um grupo.
    public function addSwitchToGroup(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            
            // Obter o ID do grupo com base no UUID fornecido
            $groupInfo = GroupSwitchModel::getGroupIdByUUID($data['group_id']);
            
            // Verificar se o grupo existe e obter seu ID
            if ($groupInfo) {
                $groupId = $groupInfo['id'];
                
                // Adicionar o switch ao grupo
                $addedSwitch = GroupSwitchModel::addSwitchToGroup($groupId, $data['mac_address']);

                // Verificar se o switch foi adicionado com sucesso ao grupo
                if ($addedSwitch) {
                    return $response::json([
                        'status' => 'success',
                        'msg' => 'Switch added to group successfully'
                    ], 200);
                } else {
                    return $response::json([
                        'status' => 'error',
                        'msg' => 'Failed to add switch to group'
                    ], 400);
                }
            } else {
                return $response::json([
                    'status' => 'error',
                    'msg' => 'Group not found'
                ], 404);
            }
            
        } catch (\Exception $e) {
            return $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }
            
    // Obtém os switches em um grupo.
    public function getSwitchesInGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            $groupInfo        = GroupSwitchModel::getGroupIdByUUID($data['group_id']);
            $data['group_id'] = $groupInfo['id'];
            $data = GroupSwitchModel::getSwitchesInGroup($data['group_id']);
            
            if ($data) {
                $response::json([
                    'status' => 'success',
                    'dados' => $data
                ], 200);
            }else {
                $response::json([
                    'status' => 'success',
                    'msg' => 'Não há switches nesse grupo'
                ], 200);
            }
            
            
        } catch (\Exception $e) {
            $response::json([
                'status' => 'error',
                'msg' => $e->getMessage()
            ], 500);
        }
    }

    // Verifica se um switch está em algum grupo.
    public function checkSwitchInGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::checkSwitchInGroup($data['mac_address']);
            
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

    // Remove um switch de um grupo.
    public function removeSwitchFromGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::removeSwitchFromGroup($data['mac_address']);
            
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

    // Deleta um grupo e remove todos os seus switches associados.
    public function deleteGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            // $deleted = true;
            $deleted = GroupSwitchModel::softDelete($data['group_id']) ;
            if($deleted){
                $groupInfo        = GroupSwitchModel::getGroupIdByUUID($data['group_id']);
                $data['group_id'] = $groupInfo['id'];
                $data   = GroupSwitchModel::removeAllSwitchesFromGroup($data['group_id']) ;
                $deleted  = $data ? $data : 'Não há switches nesse grupo';
            }
            
            if ($deleted) {
                $response::json([
                    'status' => 'success',
                    'dados' => $deleted
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