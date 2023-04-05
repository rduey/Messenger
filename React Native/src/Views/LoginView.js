/*
 * Resources:
 * https://code.tutsplus.com/tutorials/common-react-native-app-layouts-login-page--cms-27639
 * https://reactnative.dev/docs/network
 */

import React, {useState, useEffect} from 'react';
import {
  StyleSheet,
  Text,
  View,
  Image,
  TextInput,
  TouchableOpacity,
} from 'react-native';

const LoginView = ({navigation}) => {
  const [email, setEmail] = useState();
  const [password, setPassword] = useState();
  const [user, setUser] = useState();

  useEffect(() => {
    if (user !== undefined) {
      navigation.navigate('Workspaces', {user: user});
    }
  }, [user, navigation]);

  const login = async () => {
    await fetch('https://cse118.com/api/v1/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
      },
      body: JSON.stringify({
        email: email,
        password: password,
      }),
    })
      .then(response => {
        return response.json();
      })
      .then(json => {
        setUser(json);
      });
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>{'CSE118 Assignment 9'}</Text>
      <Image
        style={styles.logo}
        source={require('../../assets/UCSCSlugLogo.png')}
      />

      <View style={styles.inputView}>
        <TextInput
          style={styles.textInput}
          placeholder="email"
          placeholderTextColor="cornflowerblue"
          autoCapitalize="none"
          onChangeText={_email => setEmail(_email)}
          accessibilityLabel="email"
        />
      </View>

      <View style={styles.inputView}>
        <TextInput
          style={styles.textInput}
          placeholder="password"
          placeholderTextColor="cornflowerblue"
          secureTextEntry={true}
          autoCapitalize="none"
          onChangeText={_password => setPassword(_password)}
          accessibilityLabel="password"
        />
      </View>

      <TouchableOpacity
        style={styles.loginButton}
        accessibilityLabel="login"
        onPress={() => login()}>
        <Text style={styles.loginButtonText}>LOGIN</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 10,
    alignItems: 'center',
    alignContent: 'space-between',
    backgroundColor: 'white',
  },
  logo: {
    width: 120,
    height: 120,
    marginBottom: 20,
  },
  title: {
    marginTop: 20,
    margin: 20,
    fontSize: 18,
  },

  inputView: {
    backgroundColor: '#FFCC00',
    borderRadius: 10,
    width: '75%',
    height: 50,
    marginBottom: 20,
    borderColor: '#00173A',
    borderWidth: 2,
  },
  textInput: {
    flex: 1,
    height: 50,
    fontSize: 18,
    textAlign: 'center',
    color: '#00173A',
  },
  loginButtonText: {
    color: '#FFCC00',
    fontSize: 18,
    fontWeight: 'bold',
  },
  loginButton: {
    width: '40%',
    borderRadius: 30,
    height: 50,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#00173A',
    borderColor: '#FFCC00',
  },
});

export default LoginView;
