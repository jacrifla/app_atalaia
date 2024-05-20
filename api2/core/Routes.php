<?php

require_once 'Http.php';
// User
Http::post('/login', 'LoginController@login');
Http::post('/register', 'RegisterController@createUser');
Http::put('/user/update', 'UserController@updateUser');
Http::put('/user/delete', 'UserController@deleteUser');
// Switches
// Http::get('/switchgroup', 'GroupSwitchController@getGroups');
Http::post('/switches', 'SwitchController@getSwitches');
Http::post('/switches/getone', 'SwitchController@getSwitch');
Http::post('/switches/new', 'SwitchController@createSwitch');
Http::put('/switches/edit', 'SwitchController@updateSwitch');
Http::post('/switches/toggle', 'SwitchController@toggleSwitch');
Http::put('/switches/delete', 'SwitchController@deleteSwitch');

//Rotas internas
Http::post('/macAddress', 'MacAddressController@insert');
Http::put('/macAddress/edit', 'MacAddressController@update');
Http::delete('/macAddress/detele', 'MacAddressController@delete');