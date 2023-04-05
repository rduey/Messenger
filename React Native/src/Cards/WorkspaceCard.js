import React from 'react';
import {TouchableWithoutFeedback, StyleSheet, Text, View} from 'react-native';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'row',
    padding: 5,
    borderWidth: 0.5,
    borderColor: 'white',
    borderRadius: 10,
    marginVertical: 3,
    backgroundColor: 'snow',
    justifyContent: 'space-between',
  },
  item: {
    fontSize: 20,
    color: 'black',
    paddingLeft: 5,
  },
  info: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  count: {
    fontSize: 20,
    color: 'black',
  },
  arrow: {
    fontSize: 12,
    color: 'silver',
    fontWeight: 'bold',
    paddingLeft: 10,
    paddingRight: 5,
    transform: [{scaleY: 2}],
  },
});

const WorkspaceCard = ({user, members, workspace, navigation}) => {
  return (
    <TouchableWithoutFeedback
      onPress={() =>
        navigation.navigate('Channels', {
          user: user,
          members: members,
          workspace: workspace,
        })
      }>
      <View style={styles.container}>
        <Text style={styles.item}>{workspace.name}</Text>
        <View style={styles.info}>
          <Text
            style={styles.count}
            accessibilityLabel={`count for ${workspace.name}`}>
            {workspace.channels}
          </Text>
          <Text style={styles.arrow}>{'\u1433'}</Text>
        </View>
      </View>
    </TouchableWithoutFeedback>
  );
};

export default WorkspaceCard;
