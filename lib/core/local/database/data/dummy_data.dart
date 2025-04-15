import 'package:pva/feature/appointment/data/models/appointment.dart';

import '../../../../feature/chat/data/models/chat.dart';
import '../../../../feature/chat/data/models/message.dart';
import '../../../common/entities/user.dart';

final users = [
  User(id: '1', email: 'me@example.com', name: 'Me', type: UserType.patient),
  // You
  User(
      id: '2',
      email: 'drsmith@example.com',
      name: 'Dr. Smith',
      type: UserType.doctor),
  User(
      id: '3',
      email: 'drjane@example.com',
      name: 'Dr. Jane Doe',
      type: UserType.doctor),
  User(
      id: '4',
      email: 'drmike@example.com',
      name: 'Dr. Mike Johnson',
      type: UserType.doctor),
  User(
      id: '5',
      email: 'clinicianamy@example.com',
      name: 'Amy Clinician',
      type: UserType.clinician),
  User(
      id: '6',
      email: 'clinicianbob@example.com',
      name: 'Bob Clinician',
      type: UserType.clinician),
  User(
      id: '7',
      email: 'patientmary@example.com',
      name: 'Patient Mary',
      type: UserType.patient),
  User(
      id: '8',
      email: 'patientalice@example.com',
      name: 'Patient Alice',
      type: UserType.patient),
  User(
      id: '9',
      email: 'patientbob@example.com',
      name: 'Patient Bob',
      type: UserType.patient),
  User(
      id: '10',
      email: 'patientcharlie@example.com',
      name: 'Patient Charlie',
      type: UserType.patient),
];

final chats = [
  Chat(
      id: 'chat1',
      lastActivity: DateTime.now(),
      lastMessage: 'Hello!',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat2',
      lastActivity: DateTime.now(),
      lastMessage: 'How are you?',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat3',
      lastActivity: DateTime.now(),
      lastMessage: 'See you tomorrow.',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat4',
      lastActivity: DateTime.now(),
      lastMessage: 'Take care!',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat5',
      lastActivity: DateTime.now(),
      lastMessage: 'Follow-up scheduled.',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat6',
      lastActivity: DateTime.now(),
      lastMessage: 'Lab results are in.',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat7',
      lastActivity: DateTime.now(),
      lastMessage: 'Medication prescribed.',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat8',
      lastActivity: DateTime.now(),
      lastMessage: 'Appointment confirmed.',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat9',
      lastActivity: DateTime.now(),
      lastMessage: 'How is the treatment going?',
      createdAt: DateTime.now()),
  Chat(
      id: 'chat10',
      lastActivity: DateTime.now(),
      lastMessage: 'Please update me.',
      createdAt: DateTime.now()),
];

final chatParticipants = [
  {'chatId': 'chat1', 'userId': '1'}, // You
  {'chatId': 'chat1', 'userId': '2'}, // Dr. Smith
  {'chatId': 'chat2', 'userId': '1'}, // You
  {'chatId': 'chat2', 'userId': '3'}, // Dr. Jane Doe
  {'chatId': 'chat3', 'userId': '1'}, // You
  {'chatId': 'chat3', 'userId': '4'}, // Dr. Mike Johnson
  {'chatId': 'chat4', 'userId': '1'}, // You
  {'chatId': 'chat4', 'userId': '5'}, // Amy Clinician
  {'chatId': 'chat5', 'userId': '1'}, // You
  {'chatId': 'chat5', 'userId': '6'}, // Bob Clinician
  {'chatId': 'chat6', 'userId': '1'}, // You
  {'chatId': 'chat6', 'userId': '7'}, // Patient Mary
  {'chatId': 'chat7', 'userId': '1'}, // You
  {'chatId': 'chat7', 'userId': '8'}, // Patient Alice
  {'chatId': 'chat8', 'userId': '1'}, // You
  {'chatId': 'chat8', 'userId': '9'}, // Patient Bob
  {'chatId': 'chat9', 'userId': '1'}, // You
  {'chatId': 'chat9', 'userId': '10'}, // Patient Charlie
  {'chatId': 'chat10', 'userId': '1'}, // You
  {'chatId': 'chat10', 'userId': '2'}, // Dr. Smith
];

final messages = [
  Message(
    id: 'msg1',
    chatId: 'chat1',
    senderId: '1',
    content: 'Hello, how can I help you?',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg2',
    chatId: 'chat1',
    senderId: '7',
    content: 'I have a headache.',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg3',
    chatId: 'chat2',
    senderId: '2',
    content: 'How are you feeling today?',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg4',
    chatId: 'chat2',
    senderId: '8',
    content: 'Much better, thank you!',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg5',
    chatId: 'chat3',
    senderId: '3',
    content: 'Your test results are normal.',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg6',
    chatId: 'chat3',
    senderId: '9',
    content: 'That’s great news!',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg7',
    chatId: 'chat4',
    senderId: '4',
    content: 'Please take the prescribed medicine.',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg8',
    chatId: 'chat4',
    senderId: '10',
    content: 'Will do, thank you!',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg9',
    chatId: 'chat5',
    senderId: '5',
    content: 'Your follow-up is scheduled for next week.',
    timestamp: DateTime.now(),
  ),
  Message(
    id: 'msg10',
    chatId: 'chat5',
    senderId: '7',
    content: 'Got it, thanks!',
    timestamp: DateTime.now(),
  ),
];

final appointments = [
  Appointment(id: '1', doctorId: '3', patientId: '1', dateTime: DateTime(2025, 4, 7,10,0 ), isVirtual: 0, profilePic: 'https://images.unsplash.com/photo-1742112008263-1079370d69e7?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Appointment(id: '2', doctorId: '3', patientId: '1', dateTime: DateTime(2025, 4, 8,10,0 ), isVirtual: 0, profilePic: 'https://images.unsplash.com/photo-1742112008263-1079370d69e7?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Appointment(id: '3', doctorId: '4', patientId: '1', dateTime: DateTime(2025, 4, 9,10,0 ), isVirtual: 1, profilePic: 'https://images.unsplash.com/photo-1742112008263-1079370d69e7?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  Appointment(id: '4', doctorId: '3', patientId: '1', dateTime: DateTime(2025, 4, 10,10,0 ), isVirtual: 0, profilePic: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')
];