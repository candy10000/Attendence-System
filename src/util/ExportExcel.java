package util;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

import entity.EmployeeList;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

//实现导出功能类
public class ExportExcel {
	
	public static void excel(List<EmployeeList> list) throws Exception {
		WritableWorkbook book=null;
		try{
			//默认在f盘下创建一个名字为“excel.xls”的空表，也可以根据需求更改路径名
			File file=new File("f://excel"+System.currentTimeMillis()+".xls");
			if(!file.exists()){
				file.createNewFile();
				System.out.println("新文件创建成功！");
			}else{
				file.createNewFile();
				System.out.println("当文件存在时，创建文件成功！");
			}
			book =Workbook.createWorkbook(file);
			WritableSheet sheet=book.createSheet("user", 0);
			//创建表头
			String []tableHead={"用户编码","用户名称","早上","下午","状态"};
			for(int j=0;j<tableHead.length;j++){
				//获取label对象
				Label label=new Label(j,0,tableHead[j]);
				//sheet将label信息写入单元格
				sheet.addCell(label);
			}
			//将用户集合写入excel
			for(int i=0;i<list.size();i++){
				sheet.addCell(new Label(0,i+1,list.get(i).getCclock()));
				sheet.addCell(new Label(1,i+1,list.get(i).getName()));
				sheet.addCell(new Label(2,i+1,list.get(i).getBdate()));
				sheet.addCell(new Label(3,i+1,list.get(i).getEdate()));	
				sheet.addCell(new Label(4,i+1,list.get(i).getState()));	
			
			}
			//关闭流
			book.write();
			book.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println("文件写入完毕！");
			
	}
}
