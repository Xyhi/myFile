# 项目Utility

## 输入

```Java
public class Utility {
    private static Scanner scanner = new Scanner(System.in);
    ...
}
```

#### readKeyBoard

##### next()/nextLine()/hasnext()

>next(): 用于读取字符或者不含空格字符串
>
>```Java
>//Out
>输入的字符串为：
>a b c
>输出的字符串为：
>a
>```
>
>nextLine(): 用于读取含有空格的字符串
>
>```Java
>//Out
>输入的字符串为：
>a b c
>输出的字符串为：
>a b c
>```
>
>hasnext(): 用于读取是否还有输入

##### readKeyBoard实例

>方法说明
>
>```Java
> private static String readKeyBoard(int limit, boolean blankReturn) {
>        String line = "";
>
>        while (scanner.hasNextLine()) {
>            line = scanner.nextLine();
>            if (line.length() == 0) {
>                if (blankReturn) return line;
>                else continue;
>            }
>
>            if (line.length() < 1 || line.length() > limit) {
>                System.out.print("输入长度（不大于" + limit + "）错误，请重新输入：");
>                continue;
>            }
>            break;
>        }
>
>        return line;
>    }
>```
>
>```Java
>//首先 readKeyBoard是在Utility类中单独定义的，所以权限访问参数可以设置为private
>//参数列表说明：limit限制了输入的字符数目，blankReturn表示是否接受''字符
>private static String readKeyBoard(int limit, boolean blankReturn){
>    String line = "";
>    //当还有输入时
>    while(scanner.hasNextLine()) {
>        //从scanner中读取字符串
>        line = scanner.nextLine();
>        //用于判断是否可以接受''输入
>        if(line.length == 0){
>            //表示可以接受''输入
>            if(blankReturn){
>                return line;
>            }else{    //不可以接受，则重新进行接收
>                continue;
>            }
>        }
>        //用来判断limit情况
>        if (line.length() < 1 || line.length() > limit) {
>            System.out.print("输入长度（不大于" + limit + "）错误，请重新输入：");
>            continue;
>        }
>        break;
>    }
>    return line;
>}





















