<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/GroupSwitchModel.php';
require_once './model/UserModel.php';

class GroupSwitchController
{
    
    public function createGroup(Request $request, Response $response)
    {
        try {
            
            $data            = $request->bodyJson();
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
            
    public function getSwitchesInGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            
            $data = GroupSwitchModel::getSwitchesInGroup($data['group_id']);
            
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

    public function addSwitchToGroup(Request $request, Response $response)
    {
        try {
            
            $data = $request->bodyJson();
            $data             = $request->bodyJson();
            $groupInfo        = GroupSwitchModel::getGroupIdByUUID($data['group_id']);
            $data['group_id'] = $groupInfo['id'];
            $group            = GroupSwitchModel::addSwitchToGroup($data);
            
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

    public function toggleGroup(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $groupId = $data['group_id'];
            
            $success = GroupSwitchModel::toggleGroup($groupId);
            
            if ($success) {
                $response::json([
                    'status' => 'success',
                    'msg' => $success
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

    public function deleteGroup(Request $request, Response $response)
    {
        try {
            $data = $request->bodyJson();
            $groupId = $data['group_id'];
            
            // Remover switches associados ao grupo
            $successRemoveSwitches = GroupSwitchModel::removeAllSwitchesFromGroupByGroupId($groupId);
            // var_dump($successRemoveSwitches);
            
            // Excluir o grupo
            $successDeleteGroup = GroupSwitchModel::softDelete($groupId);
    
            if ($successDeleteGroup && $successRemoveSwitches) {
                $response::json([
                    'status' => 'success',
                    'msg' => $successDeleteGroup
                ], 200);
            } else {
                $response::json([
                    'status' => 'error',
                    'msg' => 'Failed to delete group and associated switches'
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
        