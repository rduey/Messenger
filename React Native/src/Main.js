/*
 * Copyright (C) 2022 David C. Harrison. All right reserved.
 *
 * You may not use, distribute, publish, or modify this code without
 * the express written permission of the copyright holder.
 */

/* **************************************************************************
 *
 * This is simply a placeholder, create your React Native Components in the
 * src folder with a sane sub-folder structure, possibly something like:
 *
 *  src
 *     Views
 *       LoginView.js
 *       MessageView.js
 *       etc.
 *     Lists
 *       WorkspaceList.js
 *       ChannelList.js
 *       etc.
 *     Cards
 *       WorkspaceCard.js
 *       ChannelCard.js
 *       etc.
 *     Repos
 *         WorkspaceRepo.js
 *         ChannelRepo.js
 *         etc.
 *
 * This title and logo image should go in src/Views/LoginView.js
 *
 * **************************************************************************/

import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';

import LoginView from './Views/LoginView';
import WorkspaceList from './Lists/WorkspaceList';
import ChannelList from './Lists/ChannelList';
import MessageList from './Lists/MessageList';
import MessageView from './Views/MessageView';
import NewMessageView from './Views/NewMessageView';

const Stack = createStackNavigator();
export const ViewModel = React.createContext();

const Main = () => {
  const [messages, setMessages] = React.useState();

  const getMessages = async (user, channel) => {
    await fetch(`https://cse118.com/api/v1/channel/${channel.id}/message`, {
      method: 'GET',
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${user.accessToken}`,
      },
    })
      .then(response => {
        return response.json();
      })
      .then(json => {
        json.sort((x, y) => y.posted.localeCompare(x.posted));
        setMessages(json);
      });
  };

  return (
    <ViewModel.Provider value={{messages, getMessages}}>
      <NavigationContainer>
        <Stack.Navigator
          screenOptions={{
            animationEnabled: false, // Animations mess with Jest and Testing Library
          }}>
          <Stack.Screen name="Login" component={LoginView} />
          <Stack.Screen
            name="Workspaces"
            component={WorkspaceList}
            options={() => ({
              title: 'Workspaces',
              headerBackTitle: 'Login',
              headerBackAccessibilityLabel: 'logout',
            })}
          />

          <Stack.Screen
            name="Channels"
            component={ChannelList}
            options={({route}) => ({
              title: route.params.workspace.name,
              headerBackTitle: 'Workspaces',
              headerBackAccessibilityLabel: 'back to workspaces',
            })}
          />
          <Stack.Screen
            name="Messages"
            component={MessageList}
            options={({route}) => ({
              title: route.params.channel.name,
              headerBackTitle: 'Channels',
              headerBackAccessibilityLabel: 'back to channels',
            })}
          />
          <Stack.Screen
            name="Message"
            component={MessageView}
            options={({route}) => ({
              title: route.params.members.find(
                x => x.id === route.params.message.member,
              ).name,
              headerBackTitle: 'Messages',
              headerBackAccessibilityLabel: 'back to channel',
            })}
          />
          <Stack.Screen
            name="New Message"
            component={NewMessageView}
            options={() => ({
              title: 'New Message',
              headerBackTitle: 'Messages',
              headerBackAccessibilityLabel: 'back to channel',
            })}
          />
        </Stack.Navigator>
      </NavigationContainer>
    </ViewModel.Provider>
  );
};

export default Main;
