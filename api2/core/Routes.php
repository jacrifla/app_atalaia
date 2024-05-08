<?php

require_once 'Http.php';

Http::get('/switches', 'SwitchController@getSwitches');
Http::post('/switches/getone', 'SwitchController@getSwitch');
// Http::get('/switchgroup', 'GroupSwitchController@getGroups');
Http::post('/login', 'LoginController@login');
Http::post('/register', 'RegisterController@createUser');
Http::post('/switches/new', 'SwitchController@createSwitch');
Http::put('/switches/edit', 'SwitchController@updateSwitch');
Http::put('/switches/toggle', 'SwitchController@toggleSwitch');
Http::put('/switches/delete', 'SwitchController@deleteSwitch');

//Rotas internas
Http::post('/macAddress', 'MacAddressController@insert');
Http::put('/macAddress/edit', 'MacAddressController@update');
Http::delete('/macAddress/detele', 'MacAddressController@delete');