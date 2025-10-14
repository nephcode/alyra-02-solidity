// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Notes is Ownable {

    struct Student {
        string name;
        uint noteBiology;
        uint noteMaths;
        uint noteFr;
    }

    mapping(address => bool) teachers;
    Student[] students;

   constructor() Ownable(msg.sender) { }

    modifier isTeacher() {
        require(teachers[msg.sender], "Not a teacher");
        _;
    }

    function addTeacher(address _teacherAddress) external onlyOwner {
        teachers[_teacherAddress] = true;
    }

    function addStudent(string memory _name) external isTeacher {
        students.push(Student(_name, 0, 0, 0));
    }

    function stringsEquals(string memory _string1, string memory _string2) pure private returns (bool) {
        return keccak256(abi.encodePacked(_string1)) == keccak256(abi.encodePacked(_string2));
    }

    function getStudentFromName(string memory _name) private view returns (uint) {
        for (uint i = 0; i < students.length; i++) {
            if (stringsEquals(students[i].name, _name)) {
                return i;
            }
        }
        revert("Student not found");
    }

    function setNote(string memory _name, string memory _course, uint _note) external isTeacher {
        uint idStudent = getStudentFromName(_name);
        if (stringsEquals(_course, "biology")) {
            students[idStudent].noteBiology = _note;
        } else if (stringsEquals(_course, "maths")) {
            students[idStudent].noteMaths = _note;
        } else if (stringsEquals(_course, "french")) {
            students[idStudent].noteFr = _note;
        } else {
            revert("Type a real course");
        }
    }

    function getNote(string memory _name, string memory _course) external view returns(uint) {
        uint idStudent = getStudentFromName(_name);
        if (stringsEquals(_course, "biology")) {
            return students[idStudent].noteBiology;
        } else if (stringsEquals(_course, "maths")) {
            return students[idStudent].noteMaths;
        } else if (stringsEquals(_course, "french")) {
            return students[idStudent].noteFr;
        } else {
            revert("Type a real course");
        }
    }

    function averageStudent(string memory _name) public view isTeacher returns(uint) {
        uint idStudent = getStudentFromName(_name);
        return (students[idStudent].noteBiology + students[idStudent].noteMaths + students[idStudent].noteFr) / 3;
    }

    function isPassing(string memory _name) external view isTeacher returns(bool) {
        return averageStudent(_name) >= 10;
    }

    function averageClassForCourse(string memory _course) external view returns(uint) {
        uint sum;
        uint count;

        for (uint i = 0; i < students.length; i++) {
            if (stringsEquals(_course, "biology")) {
                sum += students[i].noteBiology;
            } else if (stringsEquals(_course, "maths")) {
                sum += students[i].noteMaths;
            } else if (stringsEquals(_course, "french")) {
                sum += students[i].noteFr;
            }
            count++;
        }
        require(count > 0, "No students in class");
        return sum / count;
    }

    function averageClass() external view returns(uint) {
        uint totalNotes;
        uint totalStudents;

        for (uint i = 0; i < students.length; i++) {
            totalNotes += students[i].noteBiology + students[i].noteMaths + students[i].noteFr;
            totalStudents += 3;
        }

        require(totalStudents > 0, "No students in class");
        return totalNotes / totalStudents;
    }
}