"""
Program: Simple To-Do List Manager
Language: Python
Author: Anjali Reddy
Description:
A simple command-line To-Do List Manager that allows the user to:
1. Add tasks
2. View tasks
3. Delete tasks
4. Exit the program
"""

def show_menu():
    print("\n===== TO-DO LIST MANAGER =====")
    print("1. Add Task")
    print("2. View Tasks")
    print("3. Delete Task")
    print("4. Exit")
    print("==============================")

def add_task(tasks):
    task = input("Enter a new task: ").strip()
    if task:
        tasks.append(task)
        print(f"✅ Task added: {task}")
    else:
        print("⚠️ Task cannot be empty.")

def view_tasks(tasks):
    if not tasks:
        print("📭 No tasks found.")
    else:
        print("\n📝 Your Tasks:")
        for i, task in enumerate(tasks, start=1):
            print(f"{i}. {task}")

def delete_task(tasks):
    if not tasks:
        print("⚠️ No tasks to delete.")
        return
    view_tasks(tasks)
    try:
        index = int(input("Enter task number to delete: "))
        if 1 <= index <= len(tasks):
            removed = tasks.pop(index - 1)
            print(f"🗑️ Task removed: {removed}")
        else:
            print("❌ Invalid task number.")
    except ValueError:
        print("⚠️ Please enter a valid number.")

def main():
    tasks = []
    while True:
        show_menu()
        choice = input("Choose an option (1-4): ").strip()
        if choice == "1":
            add_task(tasks)
        elif choice == "2":
            view_tasks(tasks)
        elif choice == "3":
            delete_task(tasks)
        elif choice == "4":
            print("👋 Exiting... Have a productive day!")
            break
        else:
            print("⚠️ Invalid choice. Please try again.")

if __name__ == "__main__":
    main()
