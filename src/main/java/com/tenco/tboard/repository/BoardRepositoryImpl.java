package com.tenco.tboard.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tenco.tboard.model.Board;
import com.tenco.tboard.repository.interfaces.BoardRepository;
import com.tenco.tboard.util.DBUtil;

public class BoardRepositoryImpl implements BoardRepository {

	private static final String SELECT_ALL_BOARDS = " SELECT * FROM board ORDER BY created_at desc limit ? offset ? ";
	private static final String COUNT_ALL_BOARDS = " SELECT COUNT(*) as count FROM board ";

	@Override
	public void addBoard(Board board) {

	}

	@Override
	public void updateBoard(Board board, int principalId) {

	}

	@Override
	public void deleteBoard(int id, int principalId) {

	}

	@Override
	public Board getBoardById(int id) {

		return null;
	}

	@Override
	public List<Board> getAllBoards(int limit, int offset) {
		List<Board> boardsList = new ArrayList<>();

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL_BOARDS)) {
			pstmt.setInt(1, limit);
			pstmt.setInt(2, offset);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				boardsList.add(Board.builder()
                        .id(rs.getInt("id"))
                        .userId(rs.getInt("user_id"))
                        .title(rs.getString("title"))
                        .content(rs.getString("content"))
                        .createdAt(rs.getTimestamp("created_at"))
                        .build());
								
			}
			System.out.println("BoardRepositoryImpl - 로깅 : count " + boardsList.size());

		} catch (Exception e) {
			e.printStackTrace();
		}


		return boardsList;
	}

	@Override
	public int getTotalBoardCount() {
		int count = 0;
		
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(COUNT_ALL_BOARDS)){
				
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("로깅 totoalCount : " + count);
		return count;
	}

}
