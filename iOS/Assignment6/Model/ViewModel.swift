/*
 Resources:
 https://stackoverflow.com/questions/39161168/how-to-compare-two-array-of-objects
 */
import Foundation

class ViewModel: ObservableObject {
    @Published var authorized: Bool = false
    
    @Published var credentials = Credentials(email: "", password: "")
    @Published var user = User(id: UUID(), name: "", accessToken: "")
    @Published var newMessage = ""
    @Published var new = ""
    
    @Published var allMembers = [Member]()
    @Published var members = [Member]()
    @Published var workspaces = [Workspace]()
    @Published var channels = [Channel]()
    @Published var messages = [Message]()
    
    func login() {
        Task {
            let (loaded, success) = try! await UserRepo.login(credentials: self.credentials)
            if success {
                DispatchQueue.main.async {
                    self.user = loaded
                    self.authorized = true
                }
            }
        }
    }
    
    func getAllMembers() {
        Task {
            let loaded = try! await MemberRepo.getAllMembers(user: self.user)
            DispatchQueue.main.async {
                self.allMembers = loaded
            }
        }
    }
    
    func getMembers(workspace: Workspace) {
        Task {
            let loaded = try! await MemberRepo.getMembers(user: self.user, workspace: workspace)
            DispatchQueue.main.async {
                self.members = loaded
            }
        }
    }
    
    func getWorkspaces() {
        Task {
            let loaded = try! await WorkspaceRepo.getWorkspaces(user: self.user)
            DispatchQueue.main.async {
                self.workspaces = loaded
            }
        }
    }
    
    func getChannels(workspace: Workspace) {
        Task {
            let loaded = try! await ChannelRepo.getChannels(user: self.user, workspace: workspace)
            DispatchQueue.main.async {
                self.channels = loaded
            }
        }
    }
    
    func getMessages(channel: Channel) {
        Task {
            let loaded = try! await MessageRepo.getMessages(user: self.user, channel: channel)
            DispatchQueue.main.async {
                self.messages = loaded
            }
        }
    }
    
    func postMessage(channel: Channel) {
        Task {
            try! await MessageRepo.postMessage(user: self.user, channel: channel, content: self.newMessage)
            DispatchQueue.main.async {
                self.getMessages(channel: channel)
            }
        }
    }
    
    func deleteMessage(message: Message, channel: Channel) {
        Task {
            try! await MessageRepo.deleteMessage(user: self.user, message: message)
            DispatchQueue.main.async {
                self.getMessages(channel: channel)
            }
        }
    }
    
    func postWorkspace() {
        Task {
            try! await WorkspaceRepo.postWorkspace(user: self.user, name: self.new)
            DispatchQueue.main.async {
                self.getWorkspaces()
            }
        }
    }
    
    func deleteWorkspace(workspace: Workspace) {
        Task {
            try! await WorkspaceRepo.deleteWorkspace(user: self.user, workspace: workspace)
            DispatchQueue.main.async {
                self.getWorkspaces()
            }
        }
    }
    
    func postChannel(workspace: Workspace) {
        Task {
            try! await ChannelRepo.postChannel(user: self.user, workspace: workspace, name: self.new)
            DispatchQueue.main.async {
                self.getChannels(workspace: workspace)
            }
        }
    }
    
    func deleteChannel(workspace: Workspace, channel: Channel) {
        Task {
            try! await ChannelRepo.deleteChannel(user: self.user, channel: channel)
            DispatchQueue.main.async {
                self.getChannels(workspace: workspace)
            }
        }
    }
    
    func addMember(member: Member, workspace: Workspace) {
        Task {
            try! await MemberRepo.postMember(user: self.user, member: member, workspace: workspace)
            DispatchQueue.main.async {
                self.getMembers(workspace: workspace)
            }
        }
    }
    
    func removeMember(member: Member, workspace: Workspace) {
        Task {
            try! await MemberRepo.deleteMember(user: self.user, member: member, workspace: workspace)
            DispatchQueue.main.async {
                self.getMembers(workspace: workspace)
            }
        }
    }
    
    func otherMembers() -> [Member] {
        var difference = self.allMembers.filter({ member in
            !(self.members
                    .contains(where: { $0.id == member.id }))
            })
        difference.removeAll(where: { $0.id == user.id })
        return difference
    }
    
    
//    func getUser(id: Int) async {
//        if !(users.contains(where: { $0.id == id })) {
//            Task {
//                let user = try! await UserRepo.get(id: id)
//                DispatchQueue.main.async {
//                    if !(self.users.contains(where: { $0.id == id })) {
//                        self.users.append(user)
//                    }
//                }
//            }
//        }
//    }
    
//    func getPosts() {
//        Task {
//            let loaded = try! await PostRepo.load()
//            DispatchQueue.main.async {
//                self.posts = loaded
//            }
//        }
//    }
}
