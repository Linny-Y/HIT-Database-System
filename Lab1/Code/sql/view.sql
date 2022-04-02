---------------------------------
-- Create view
---------------------------------
CREATE VIEW CS AS 
SELECT sno,sname,faculty.fno FROM faculty,class,student 
WHERE (faculty.fname = "CS") AND (faculty.fno = class.fno) AND (student.cno = class.cno) ;

CREATE VIEW all_courses AS
SELECT scheduleno,coursename,tname,`year`,semester FROM schedule,course,teacher 
WHERE schedule.teacherno=teacher.tno AND course.courseno = schedule.courseno;

CREATE VIEW student_courses AS
SELECT studentno,sname,course.courseno AS courseno,scheduleno,score,teacherno,coursename FROM `choose`,student,course 
WHERE `choose`.studentno=student.sno AND course.courseno=`choose`.courseno;

