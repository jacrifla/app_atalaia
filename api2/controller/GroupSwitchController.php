<?php

require_once './core/Request.php';
require_once './core/Response.php';
require_once './model/GroupSwitchModel.php';
require_once './model/UserModel.php';

class GroupSwitchController
{
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
        