package test;
import com.baidu.speech.serviceapi.Sample;

public class Speech2Text {
	//分段数量
	public static int num = 11;
    public static void main(String[] args){
    	Sample a = new Sample();
    	String file = "";
    	for (int i = 1; i <= num; i++) {
    		try {
    			if (i < 10) file =  "00"+i+".wav";
    			else file = "0"+i+".wav";
        		a.run(file);
        	}
        	catch(Exception e){ System.out.println(e);}
    	}
    }
}
