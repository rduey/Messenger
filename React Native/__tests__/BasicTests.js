/*
 * Copyright (C) 2022 David C. Harrison. All right reserved.
 *
 * You may not use, distribute, publish, or modify this code without
 * the express written permission of the copyright holder.
 */

/* **************************************************************************
 * Must be using Node.js Version 17 or above
 * **************************************************************************/

/* **************************************************************************
 * DO NOT MODIFY THIS FILE
 * **************************************************************************/

import React from 'react';
import {
  render,
  screen,
  fireEvent,
  cleanup,
  waitFor,
  waitForElementToBeRemoved,
} from '@testing-library/react-native';

import App from '../App';

const login = (email = 'molly@cse118.com', password = 'molly') => {
  render(<App />);
  fireEvent.changeText(screen.getByLabelText('email'), email);
  fireEvent.changeText(screen.getByLabelText('password'), password);
  fireEvent.press(screen.getByLabelText('login'));
};

const waitForTextThenClick = async text => {
  await waitFor(() => screen.getByText(text));
  fireEvent.press(screen.getByText(text));
};

const waitForLabelTextThenClick = async labelText => {
  await waitFor(() => screen.getByLabelText(labelText));
  fireEvent.press(screen.getByLabelText(labelText));
};

const waitForFirstLabelTextThenClick = async labelText => {
  await waitFor(() => screen.getAllByLabelText(labelText));
  fireEvent.press(screen.getAllByLabelText(labelText)[0]);
};

it('Accepts valid creditials', async () => {
  login();
  await waitFor(() => screen.getByLabelText('logout'));
});

it('Rejects invalid creditials', async () => {
  login('molly@cse118.com', 'wrong');
  screen.getByLabelText('login');
  cleanup();
});

it('Logs out after sucessful log in', async () => {
  login();
  await waitForLabelTextThenClick('logout');
  await waitFor(() => screen.getByLabelText('login'));
  cleanup();
});

it('Shows Workspaces', async () => {
  login();
  await waitFor(() => screen.getByText('CSE118 Workspace'));
  cleanup();
});

it('Drills Down to Channels', async () => {
  login();
  await waitForTextThenClick('CSE118 Workspace');
  await waitFor(() => screen.getByText('Assignment 6'));
});

it('Drills Down to Messages', async () => {
  login();
  await waitForTextThenClick('CSE118 Workspace');
  await waitForTextThenClick('Assignment 6');
  await waitFor(() => screen.getByText('Dr Harrison'));
});

it('Drills Down to Message', async () => {
  login();
  await waitForTextThenClick('CSE118 Workspace');
  await waitForTextThenClick('Assignment 6');
  await waitForTextThenClick('Dr Harrison');
  await waitFor(() => screen.getByLabelText('back to channel'));
});

it('Returns to Channel with Back Navigation', async () => {
  login();
  await waitForTextThenClick('Molly Workspace');
  await waitForTextThenClick('Molly Channel');
  await waitForLabelTextThenClick('add message');
  await waitForLabelTextThenClick('back to channel');
  cleanup();
});

it('Returns to Channel with Cancel', async () => {
  login();
  await waitForTextThenClick('Molly Workspace');
  await waitForTextThenClick('Molly Channel');
  await waitForLabelTextThenClick('add message');
  await waitForTextThenClick('Cancel');
  cleanup();
});

/*
 * Navigate to a known Channel
 * Add a message
 * Check it appears in the Channel Message list
 * Navigate back up to Channel list
 * Check the Channel Message count went up by one
 * Navigate back to the known Channel
 * Delete the message
 * Check it has been removed from the Channel Message list
 * Navigate back up to Channel list
 * Check the Channel Message count went down by one
 */
const addAndDeleteMessage = async () => {
  login();
  let content = new Date().toISOString();
  await waitForTextThenClick('Molly Workspace');
  await waitForTextThenClick('Second Molly Channel');
  let count = Number(
    screen.getByLabelText('count for Second Molly Channel').children[0],
  );
  await waitForLabelTextThenClick('add message');
  fireEvent.changeText(screen.getByLabelText('content'), content);
  fireEvent.press(screen.getByLabelText('add'));
  await waitFor(() => screen.getByLabelText('add message'));
  await waitFor(() => screen.getByText(content));
  await waitForLabelTextThenClick('back to channels');
  await waitFor(() => screen.getByText('Second Molly Channel'));
  let newCount = Number(
    screen.getByLabelText('count for Second Molly Channel').children[0],
  );
  fireEvent.press(screen.getByText('Second Molly Channel'));
  fireEvent(screen.getByText(content), 'swipeableRightOpen');
  await waitForFirstLabelTextThenClick('delete message');
  await waitForElementToBeRemoved(() => screen.getByText(content));
  await waitForLabelTextThenClick('back to channels');
  await waitFor(() => screen.getByText('Second Molly Channel'));
  let finalCount = Number(
    screen.getByLabelText('count for Second Molly Channel').children[0],
  );
  cleanup();
  expect(newCount).toBe(isNaN(count) ? 1 : count + 1);
  expect(finalCount).toBe(count);
};

it('Adds and Deletes Message 1', async () => {
  await addAndDeleteMessage();
});

it('Adds and Deletes Message 2', async () => {
  await addAndDeleteMessage();
});

it('Adds and Deletes Message 3', async () => {
  await addAndDeleteMessage();
});

it('Adds and Deletes Message 4', async () => {
  await addAndDeleteMessage();
});

it('Adds and Deletes Message 5', async () => {
  await addAndDeleteMessage();
});
