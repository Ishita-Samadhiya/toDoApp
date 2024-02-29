//
//  ContentView.swift
//  toDo
//
//  Created by StudentAM on 2/29/24.
//

import SwiftUI

struct ContentView: View {
    // State variables to manage tasks and UI elements
    @State private var tasks: [String] = [] // Array to hold tasks
    @State private var numTasks = 0 // Number of tasks
    @State private var task: String = "" // Input field for new task
    @State private var showingAlert = false // Flag to show alert
    
    // Function to add a task to the list
    func addTask(){
        if task.isEmpty {
            showingAlert = true // Show an alert if task is empty
        } else {
            numTasks += 1 // Increment number of tasks
            tasks.append(task) // Append task to tasks array
            task = "" // Clear the task field
        }
    }
    
    // Function to delete a task from the list
    func deleteItem(offset: IndexSet){
        numTasks -= 1 // Decrement number of tasks
        tasks.remove(atOffsets: offset) // Remove task at specified index
    }
    
    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.title)
                .disabled(true) // Disable user interaction for this text (read-only)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            Text("Number of task: \(numTasks)")
                .disabled(true) // Disable user interaction for this text (read-only)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            TextField("Enter a new Task", text: $task)
                .textFieldStyle(RoundedBorderTextFieldStyle()) // Apply rounded border style to the text field
        }
        .padding()
        
        HStack{
            Button(action: {
                addTask()
            }) {
                Text("Add Task")
                    .padding(10)
                    .background(task.count > 0 ? Color.blue : Color.gray) // Change button color based on task input
                    .foregroundColor(.white) // Set text color to white
            }
            .cornerRadius(10) // Apply corner radius to the button
            .alert("Cannot create empty task!", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { } // Add a button to dismiss the alert
            }
            
            Button(action: {
                tasks.removeAll() // Remove all tasks from the list
                numTasks = 0 // Reset the number of tasks
            }) {
                Text("Delete All Tasks")
                    .padding(10)
                    .foregroundColor(.white) // Set text color to white
                    .background(tasks.count > 0 ? Color.blue : Color.gray) // Change button color based on task count
            }
            .cornerRadius(10) // Apply corner radius to the button
        }
        
        List{
            ForEach(tasks, id: \.self){ item in
                Text("\(item)")
            }
            .onDelete(perform: deleteItem) // swipe to delete functionality for list items
        }
    }
}

#Preview {
    ContentView()
}
