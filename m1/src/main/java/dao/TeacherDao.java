package dao;

import java.sql.*;
import vo.*;
import java.util.*;
import util.*;

public class TeacherDao {
	
	/*
	담당 교과목이 없어도 전체 출력
	teacherList.jsp + 화면 캡쳐 (teacher 정보) + 샘플데이터 추가
	null값 nvl 사용 - 공백 출력
	
	SELECT t.teacher_no, t.teacher_id, t.teacher_name, NVL(GROUP_CONCAT(s.subject_name),'') subjectName
	FROM teacher t LEFT JOIN teacher_subject ts
	ON t.teacher_no = ts.teacher_no
	LEFT JOIN subject s
	ON ts.subject_no = s.subject_no
	GROUP BY t.teacher_no, t.teacher_id, t.teacher_name
	LIMIT ?,?;
	 */
	
	// 1) 강사 리스트
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		// DB
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		//System.out.println(conn+"<--teacherDao conn--");
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, nvl(GROUP_CONCAT(s.subject_name),'') subjectName FROM teacher t LEFT JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> t = new HashMap<>();
			t.put("teacherNo", rs.getInt("teacherNo"));
			t.put("teacherId", rs.getString("teacherId"));
			t.put("teacherName", rs.getString("teacherName"));
			t.put("subjectName", rs.getString("subjectName"));
	
			list.add(t);
		}
		return list;
	}
	
	// 2) 강사 상세정보 & 수정 폼 (subjectNo,id,name,history,createdate,updatedate)
	public Teacher selectTeacherOne(int teacherNo) throws Exception {
		
		//반환할 객체
		Teacher teacher = null;
		// DB
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		String onesql ="SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, createdate, updatedate FROM teacher WHERE teacher_no =?";
		PreparedStatement stmt = conn.prepareStatement(onesql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			teacher = new Teacher();
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherId(rs.getString("teacherId"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));
			teacher.setCreatedate(rs.getString("createdate"));
			teacher.setUpdatedate(rs.getString("updatedate"));
		}
		
		return teacher;
		
	}
	
	// 3) 교사 수정 Action * teacher No,id,name,history - updatedate
	public int updateTeacher(Teacher teacher) throws Exception {
		
		int row = 0;
		
		// 저장 객체
		int teacherNo = teacher.getTeacherNo();
		String teacherID = teacher.getTeacherId();
		String teacherName = teacher.getTeacherName();
		String teacherHistory = teacher.getTeacherHistory();
		
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		String updatesql = "UPDATE teacher SET teacher_id =?, teacher_name =?, teacher_history =?, updatedate = now() where teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(updatesql);
		stmt.setInt(1,teacherNo);
		stmt.setString(2,teacherID);
		stmt.setString(3,teacherName);
		stmt.setString(4,teacherHistory);
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 4) 교사 삭제
	public int deleteTeacher(int teacherNo) throws Exception {
		
		int row = 0;
		
		// 삭제 = 저장할 객체 없음 바로 DB 연결
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		String delsql = "DELETE FROM teacher where teacher_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(delsql);
		stmt.setInt(1, teacherNo);
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	// 리스트 전체 row(페이징에 사용)
	public int selectTeacherCnt() throws Exception {
		
		int totalrow = 0; //반환타입 선언
		
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		String rowSql = "select count(*) from teacher"; // 전체 불러옴
		PreparedStatement stmt = conn.prepareStatement(rowSql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			totalrow = rs.getInt("count(*)"); //select절에 컬럼이 하나밖에 없을 때 = "count(*)" or getInt(1) 사용
		}
		return totalrow;
	}
}
