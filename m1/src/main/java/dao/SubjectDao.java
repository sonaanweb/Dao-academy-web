package dao;

import vo.*;
import util.*;
import java.sql.*;
import java.util.*;

public class SubjectDao {
	// 1) 과목 목록 + 페이징
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		// 반환 리스트
		ArrayList<Subject> list = new ArrayList<>();
		// DB
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection(); // mariadb = limit 사용 
		String sql="select subject_no subjectNo, subject_name subjectName, subject_time subjectTime, createdate, updatedate From subject limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
				Subject subject = new Subject();
				subject.setSubjectNo(rs.getInt("subjectNo"));
				subject.setSubjectName(rs.getString("subjectName"));
				subject.setSubjectTime(rs.getInt("subjectTime"));
				subject.setUpdatedate(rs.getString("createdate"));
				subject.setCreatedate(rs.getString("updatedate"));	
				list.add(subject);				
			}
		return list;
	}
	
	// 2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		
		// 추가시 영향 받는 행의 수 
		int row = 0;
		// DB -  INSERT문은 ResultSet 제외
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		String insertSql = "insert into subject(subject_name, subject_time, updatedate, createdate) values(?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(insertSql);
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	// 3) 과목삭제
	public int deleteSubject(Subject subject) throws Exception {
		int row = 0;
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		//PreparedStatement	
		return row;
	}
	
	// 4) 과목수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0; //반환타입 선언
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		//PreparedStatement
		//ResultSet
		return row;
	}
		
	// 5) 과목 하나 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection();
		//PreparedStatement
		//ResultSet
		return subject;
	}
	
	// 6) 과목전체row (페이징에 사용)
	public int selectSubjectCnt() throws Exception {
		int row = 0; //반환타입 선언
		DButil dButil = new DButil();
		Connection conn = dButil.getConnection(); // 1)우측 실행 -> 2)커넥션 타입 conn값 남음 -> 변수 conn에 들어감
		String rowSql = "select count(*) from subject"; // 전체 불러옴
		PreparedStatement stmt = conn.prepareStatement(rowSql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("count(*)");
		}
		return row;
	}
}
