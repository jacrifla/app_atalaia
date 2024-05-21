<?php

require_once 'Http.php';
// User
Http::post('/login', 'LoginController@login');
Http::post('/register', 'RegisterController@createUser');
Http::post('/user/update', 'UserController@updateUser');
Http::post('/user/delete', 'UserController@deleteUser');

// Switches
Http::post('/switches', 'SwitchController@getSwitches');
Http::post('/switches/getone', 'SwitchController@getSwitch');
Http::post('/switches/new', 'SwitchController@createSwitch');
Http::post('/switches/edit', 'SwitchController@updateSwitch');
Http::post('/switches/toggle', 'SwitchController@toggleSwitch');
Http::post('/switches/delete', 'SwitchController@deleteSwitch');

//Groups
// Http::post('/groups', 'GroupSwitchController@getGroups');
// Http::post('/groups/getone', 'GroupSwitchController@getGroup');
// Http::post('/groups/new', 'GroupSwitchController@createGroup');
// Http::post('/groups/edit', 'GroupSwitchController@updateGroup');
// Http::post('/groups/toggle', 'GroupSwitchController@toggleGroup');
// Http::post('/groups/delete', 'GroupSwitchController@deleteGroup');

//Rotas internas
Http::post('/macAddress', 'MacAddressController@insert');
Http::put('/macAddress/edit', 'MacAddressController@update');
Http::delete('/macAddress/delete', 'MacAddressController@delete');