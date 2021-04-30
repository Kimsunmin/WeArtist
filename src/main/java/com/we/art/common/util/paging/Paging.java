package com.we.art.common.util.paging;

public class Paging {
	//입력받을 값
	private String type; //페이징 처리할 항목
	private int currentPage; //현재페이지
	private int total; //전체 게시물 수
	private int cntPerPage; //페이지당 게시물 수
	private int blockCnt; //한 줄에 표시될 블록 갯수
	
	
	//계산해야하는 값
	private int lastPage; //마지막 페이지
	private int blockStart; //시작 블록
	private int blockEnd; //끝 블록
	private int prev; //이전 버튼에 들어갈 값
	private int next; // 다음 버튼에 들어갈 값
	
	
	//쿼리에서 between문에 지정할 rownum 값
	private int queryStart; 
	private int queryEnd;
	
	private Paging(PagingBuilder builder) {
		this.type = builder.type;
		this.currentPage = builder.currentPage;
		this.total = builder.total;
		this.cntPerPage = builder.cntPerPage;
		this.blockCnt = builder.blockCnt;
		calLastPage();
		calBlockStartAndEnd();
		calQueryStartAndEnd();
		calPrevAndNext();
	}
	
	private void calLastPage() {
	      lastPage = (total-1)/cntPerPage + 1 ;
	   }
	
	private void calBlockStartAndEnd() {
		//현재 페이지 값보다 작은 blockCnt의 배수 중 가장 큰 값에 1을 더하면 시작값
		blockStart = ((currentPage-1)/blockCnt) * blockCnt + 1;
		blockEnd = blockStart+blockCnt-1;
		
		blockStart = blockStart< 1 ? 1 : blockStart;
		blockEnd = blockEnd > lastPage ? lastPage : blockEnd;
		
	}
	
	private void calQueryStartAndEnd() {
		queryEnd = currentPage * cntPerPage;
		queryStart = queryEnd - cntPerPage +1;
	}
	
	private void calPrevAndNext() {
		prev = currentPage == 1 ?currentPage : currentPage-1;
		next = currentPage == lastPage? lastPage : lastPage+1;
	}
	
	public static PagingBuilder builder() {
		return new PagingBuilder();
	}
	
	public static class PagingBuilder{
		//입력받을 값
		private String type; //페이징 처리할 항목
		private int currentPage; //현재페이지
		private int total; //전체 게시물 수
		private int cntPerPage; //페이지당 게시물 수
		private int blockCnt; //한 줄에 표시될 블록 갯수
		
		public PagingBuilder type(String val) {
			this.type = val;
			return this;
		}
		public PagingBuilder currentPage(int val) {
			this.currentPage = val;
			return this;
		}
		public PagingBuilder total(int val) {
			this.total = val;
			return this;
		}
		public PagingBuilder cntPerPage(int val) {
			this.cntPerPage = val;
			return this;
		}
		public PagingBuilder blockCnt(int val) {
			this.blockCnt = val;
			return this;
		}
		
		public Paging build() {
			return new Paging(this);
		}
	}
	
	public String getType() {
		return type;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public int getTotal() {
		return total;
	}
	public int getCntPerPage() {
		return cntPerPage;
	}
	public int getBlockCnt() {
		return blockCnt;
	}
	public int getLastPage() {
		return lastPage;
	}
	public int getBlockStart() {
		return blockStart;
	}
	public int getBlockEnd() {
		return blockEnd;
	}
	public int getPrev() {
		return prev;
	}
	public int getNext() {
		return next;
	}
	public int getQueryStart() {
		return queryStart;
	}
	public int getQueryEnd() {
		return queryEnd;
	}
	
	
}
