package com.tenco.tboard.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tenco.tboard.model.Comment;
import com.tenco.tboard.repository.interfaces.CommentRepository;
import com.tenco.tboard.util.DBUtil;

public class CommentRepositoryImpl implements CommentRepository {

	private static final String INSERT_COMMNET_SQL = " INSERT INTO comments (board_id, user_id, content) VALUES (?, ? , ?) ";
	private static final String DELETE_COMMNET_SQL = " DELETE FROM comments WHERE id = ? ";
	private static final String SELECT_COMMNET_BY_ID = " SELECT * FROM comments WHERE id = ?  ";
	private static final String SELECT_COMMNETS_BY_BOARD_ID = " SELECT c.*, u.username FROM comments c JOIN users u ON c.user_id = u.id WHERE c.board_id = ? ORDER BY c.created_at DESC ";

	@Override
	public void addComment(Comment comment) {
		try (Connection conn = DBUtil.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(INSERT_COMMNET_SQL)) {
				pstmt.setInt(1, comment.getBoardId());
				pstmt.setInt(2, comment.getUserId());
				pstmt.setString(3, comment.getContent());
				pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteComment(int id) {
		try (Connection conn = DBUtil.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement pstmt = conn.prepareStatement(DELETE_COMMNET_SQL)) {
				pstmt.setInt(1, id);
				pstmt.executeUpdate();
				conn.commit();
			} catch (Exception e) {
				conn.rollback();
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Comment getCommentById(int id) {
		Comment comment = null;
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELECT_COMMNET_BY_ID)) {
			pstmt.setInt(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					comment = new Comment(rs.getInt("id"), 
							rs.getInt("board_id"), 
							rs.getInt("user_id"),
							rs.getString("content"), 
							rs.getTimestamp("created_at"),
							rs.getString("username"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comment;
	}

	@Override
	public List<Comment> getCommentsByBoardId(int boardId) {
		List<Comment> commentList = new ArrayList<>();
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(SELECT_COMMNETS_BY_BOARD_ID)) {
			pstmt.setInt(1, boardId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Comment comment = new Comment(rs.getInt("id"), 
							rs.getInt("board_id"), 
							rs.getInt("user_id"),
							rs.getString("content"),
							rs.getTimestamp("created_at"),
							rs.getString("username"));
							commentList.add(comment);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commentList;
	}
}
