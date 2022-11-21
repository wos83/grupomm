import React from 'react';
import { StatusBar, Text, View } from 'react-native';
import { useTheme } from 'styled-components';

import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import TabBar from './components/TabBar';
import Dashboard from './modules/dashboard';
import Login from './modules/login';
import Map from './modules/map';

const Stack = createStackNavigator();

const Main = (): JSX.Element => {
  return (
    <NavigationContainer>
      <StatusBar
        barStyle="light-content"
        backgroundColor="#00000000"
        translucent
      />
      <Stack.Navigator
        screenOptions={{
          headerShown: false,
        }}>
        <Stack.Screen name="Login" component={Login} />
        <Stack.Screen name="TabNavigation" component={TabNavigation} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

const TopTab = createMaterialTopTabNavigator();

const HomeTabs = (): JSX.Element => {
  return (
    <TopTab.Navigator
      screenOptions={{
        tabBarLabelStyle: {
          fontSize: 12,
          marginBottom: 0,
        },
        tabBarItemStyle: {
          justifyContent: 'flex-end',
          borderBottomColor: '#E5E9F2',
          borderBottomWidth: 6,
        },
        tabBarContentContainerStyle: {
          marginTop: 40,
        },
        tabBarIndicatorContainerStyle: {
          justifyContent: 'center',
          width: '100%',
          zIndex: 1001,
        },
        tabBarIndicatorStyle: {
          height: 6,
          borderRadius: 4,
        },
        tabBarStyle: { backgroundColor: useTheme().colors.body },
      }}>
      <TopTab.Screen name="Dashboard" component={Dashboard} />
      <TopTab.Screen name="Reports" component={SettingsScreen} />
      <TopTab.Screen name="Commands" component={SettingsScreen} />
    </TopTab.Navigator>
  );
};

const Tab = createBottomTabNavigator();

const TabNavigation = (): JSX.Element => {
  return (
    <>
      <Tab.Navigator
        screenOptions={{
          headerShown: false,
        }}
        tabBar={(props) => <TabBar {...props} />}>
        <Tab.Screen name="Home" component={HomeTabs} />
        <Tab.Screen name="Map" component={Map} />
        <Tab.Screen name="Settings" component={SettingsScreen} />
      </Tab.Navigator>
    </>
  );
};

function SettingsScreen(): JSX.Element {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Settings!</Text>
    </View>
  );
}

export default Main;
