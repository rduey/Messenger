/*
 * Resources:
 * https://linuxhint.com/sort-array-object-property-javascript/
 */
import React, {useState} from 'react';
import {FlatList, StyleSheet, View} from 'react-native';

import WorkspaceCard from '../Cards/WorkspaceCard';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    backgroundColor: 'seashell',
  },
});

const WorkspaceList = ({route, navigation}) => {
  const {user} = route.params;
  const [workspaces, setWorkspaces] = useState();
  const [members, setMembers] = useState();

  const getWorkspaces = async () => {
    await fetch('https://cse118.com/api/v1/workspace', {
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
        setWorkspaces(json);
      });
  };

  const getMembers = async () => {
    await fetch('https://cse118.com/api/v1/member', {
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
        setMembers(json);
      });
  };
  /*
      useEffect(() => {
        const unsubscribe = navigation.addListener('focus', () => {
          // The screen is focused
          // Call any action
          getWorkspaces();
        });
        // Return the function to unsubscribe from the event so it gets removed on unmount
        return unsubscribe;
      }, [getWorkspaces, navigation]);
      */
  if (workspaces === undefined) {
    getWorkspaces();
  }
  if (members === undefined) {
    getMembers();
  }
  return (
    <View style={styles.container}>
      <FlatList
        data={workspaces}
        keyExtractor={item => item.id}
        renderItem={({item}) => (
          <WorkspaceCard
            user={user}
            members={members}
            workspace={item}
            navigation={navigation}
          />
        )}
      />
    </View>
  );
};

export default WorkspaceList;
