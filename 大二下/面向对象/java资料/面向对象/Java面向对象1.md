240

### JAVA 面向对象(初级)

#### 类与对象

* 方法区常量池（加载类的 **属性信息** 以及 **方法(行为)信息** ）

  <img src=".\001.jpg" style="zoom:40%;" />

  <font color="grey">*ps:基本数据类型会直接在堆中存储，而string是引用类型，会在方法区的常量池中存储数据，由堆中的地址进行指向*</font>

#### 属性 / 成员变量

>1. 概念上：成员变量 = 属性 = field (字段)
>
>2. 组成：属性是类的一个组成部分，一般是基本数据类型。也可以是引用类型(对象、数组)
>
>3. 属性的定义：
>
>   > 属性的定义格式：访问修饰符 属性类型 属性名；
>   >
>   > >访问修饰符：控制属性的访问范围
>   > >
>   > >有 public, protected, default(默认), private
>   >
>   > 属性的定义类型：可以为任意类型，包含基本类型或引用类型
>   >
>   > 属性如果不赋值，有默认值，规则与其他类型一致

##### JAVA内存结构分配机制

* 栈：一般存放基本数据类型(局部变量)

* 堆：存放对象(类，数组等)

* 方法区：常量池(常量，字符串等)，类加载信息

  >1. 先加载类信息(属性, 方法信息)，且只会加载一次
  >2. 在堆中分配空间(由属性来决定)，并进行默认初始化
  >3. 把堆中的地址分配给局部变量p，即使得p指向对象
  >4. 进行指定的初始化，一般有用户进行操作

##### 成员方法

###### 成员方法介绍

* 成员方法(简称方法)

  >方法调用小结：
  >
  >1. 当程序执行到方法时，就会开辟一个独立的空间(栈空间)
  >2. 当方法执行完毕后，或者执行到return语句就会返回
  >3. 返回到调用方法的地方，继续执行后面的代码
  >4. 当main方法栈执行完毕，整个程序退出

* 成员方法的好处

  >1. 提高代码的复用性
  >2. 可以将实现的细节封装起来，供其他用户调用

* 方法定义的格式(要满足小驼峰法：如 ***getSum/getAverage***)

  >访问修饰符 返回数据类型 方法名 (形参列表...) {   // 方法体
  >
  >​            语句；
  >
  >​            return...; 
  >
  >}

* 一个方法只能返回一个返回值，如果需要返回多个返回值，则一种解决方法是返回一个数组

* 同一个类中的方法调用：直接调用即可不需要创建新的对象，跨类如A类调用B类中的方法则需要通过创建对象来进行调用

  ```Java
  class A {
      public void haha(){
          huhu();
          System.out.println("haha");
      }
      public void huhu(){
          System.out.println("huhu");
      }
  }

###### 成员方法传参机制

###### 递归方法调用

* 执行一个方法时，就会创建一个新的受保护的独立空间(栈空间)
* 方法的局部变量是独立的，不会相互影响
* 如果方法中使用的是引用类型的变量则会共享引用类型的数据

#### 方法重载(OverLoad)

##### 基本介绍

* java中允许一个类中，多个同名方法的存在，但要求形参列表不一致

  >方法名：必须相同
  >
  >形参列表：必须不同（形参类型或个数或顺序，至少有一个不一样，参数名无要求）
  >
  >返回类型：无要求

##### 可变参数

* java允许将同一个类中多个同名同功能但参数个数不同的方法，封装成一个方法

* 基本语法

  >访问修饰符 返回类型 方法名(数据类型...形参名) {
  >
  >}

* 其中定义的形参名当做数组使用

  ```Java
  public class Main {
      public static void main(String[] args) {
          Solution solution = new Solution();
          int ret = solution.sum(1, 2, 3, 6, 9);
          System.out.println(ret);
      }
  }
  class Solution {
      public int sum(int... nums) {
          int sum = 0;
          for(int i = 0; i < nums.length; i++) {
              sum += nums[i];
          }
          return sum;
      }
  }
  ```

###### 可变参数注意事项

>1) 可变参数的实参可以为0个或任意多个
>2) 可变参数可以为数组
>3) 可变参数的本质就是数组
>4) 可变参数可以和普通类型的参数一起放在形参列表中，但必须保证可变参数在最后
>5) 一个形参列表中最多只能出现一个可变参数
>
>```java
>public int sum(String s, int... nums) // 可以
>public int sum(String s, int... nums, int... idea) // 不可以
>```

#### 变量作用域

##### 基本使用

* 主要的变量就是属性(成员变量)和局部变量

* Java中作用域的分类

  >1. 全局变量：也就是属性，作用域为整个类体
  >2. 局部变量：除了属性之外的其他变量，作用域为定义其的代码块中
  >3. 全局变量(成员变量、属性)会有默认赋值，但是局部变量必须进行赋值之后才能使用

##### 注意事项和细节说明

* 属性的定义同变量，<font color="blue">**访问修饰符**</font> <font color="orange">**属性类型 属性名**</font> (*其中访问修饰符用来控制属性的访问范围*)

* 属性会有默认赋值，同之前的默认赋值一样

* 属性和局部变量可以重名，访问时遵循就近原则(***this的使用***); 局部变量之间不能重名

* 属性的声明周期较长，随着对象的创建而创建，伴随着对象的死亡而死亡

* 作用域范围不同

  >1. 全局变量/属性：可以在本类中访问，也可以通过对象调用在别的类中得到访问
  >
  >2. 局部变量：只能在本类的对应方法中使用

* 修饰符不同

  >1. 全局变量/属性可以添加修饰符
  >2. 局部变量不可以添加修饰符

#### 构造方法/构造器

##### 基本语法

* [修饰符] 方法名(与类名相同) (形参列表) { 方法体}

* 说明

  >1. 构造器的修饰符可以默认
  >
  >2. 构造器没有返回值
  >
  >3. 方法名和类名相同
  >
  >4. 参数列表和方法规则一样
  >
  >5. 构造器的调用由系统完成
  >
  >   ```Java
  >   class Solution {
  >       String name;
  >       public Solution(String name) {
  >           this.name = name;
  >       }
  >   }

##### 基本介绍

* 构造方法又叫构造器(constructor)，是类的一种特殊的方法，主要作用是完成对新对象的初始化

* 特点

  >1. 方法名和类名相同
  >
  >2. 没有返回值
  >
  >3. 在创建对象时，系统会自动的调用该类的构造器完成对对象的初始化
  >
  >   *ps: 实际上这是由于每个类都继承了Objective类，而Objective类中定义了构造器*

##### 构造器注意事项和使用细节

* 一个类可以定义多个不同的构造器，即构造器的重载
* 构造器是完成对象的初始化，并不是创建对象
* 在创建对象时，系统自动的调用该类的构造方法
* 如果没有定义构造器，系统会自动给类生成一个默认无参构造方法
* 一旦定义了自己的构造器，默认的构造器就会被覆盖了，如果还需要使用无参构造器，则需要显式的定义一下

##### 对象创建的流程分析

> 1. 在方法区加载Person类信息
>
> 2. 在堆中分配空间
>
> 3. 完成对象初始化
>
>    >1. 默认初始化
>    >2. 显示初始化(即类中直接指定属性的值)
>    >3. 构造器的初始化
>
> 4. 把对象在堆中的地址返回给p（***故也称作对象名，对象的引用***）

##### this关键字

* 主要是解决前面变量命名问题
* java虚拟机会给每个对象分配this，来指代当前对象

<img src=".\002.jpg" style="zoom:40%;" />

* this的注意事项和使用细节

  >1. this 关键字可以用来访问本类的属性、方法、构造器
  >
  >2. this 用于区分当前累的属性和局部变量
  >
  >3. 访问成员方法的语法：this.方法名(参数列表)；
  >
  >   ```Java
  >   class Solution {
  >       String name;
  >       public void f1() {
  >           System.out.println("f1...");
  >       }
  >       public void f2() {
  >           System.out.println("f2...");
  >           f1();
  >           this.f1(); // 这里就是利用了this来访问方法
  >       }
  >   }
  >
  >4. 访问构造器的语法：this(参数列表)；***ps：只能在构造器中使用，且如果使用this来访问构造器，必须放在首句定义***
  >
  >   ```Java
  >   public class Main {
  >       public static void main(String[] args) {
  >           Solution solution = new Solution();
  >           System.out.println(solution.name);
  >       }
  >   }
  >   class Solution {
  >       String name;
  >       public Solution(String name) {
  >           this.name = name;
  >       }
  >       public Solution() {
  >           this("haha");  // 在构造器中利用this来访问其他的构造器
  >           //且只能放在构造器的首句上！！！！
  >       }
  >   }
  >
  >5. this不能在类定义的外部使用，只能在类定义基本的方法、构造器中使用
  >
  >*ps: 基本数据类型判断相同使用==，引用类型用equals*

###### this习题

>1. ```Java
>   // 返回一个double数组的最大值
>   public class Main {
>       public static void main(String[] args) {
>           double[] nums = {1.0, 2.6, 2.9, -4, 2.5, 3.9};
>           A01 a01 = new A01();
>           //这里使用了Double包装类可以完全避免了数组中如果不存在，而返回的值恰巧是求解的值的           问题
>           Double max = a01.max(nums);
>           if(max != null) {
>               System.out.println("max is " + max);
>           }else {
>               System.out.println("数组不存在");
>           }
>       }
>   }
>   class A01 {
>       public Double max (double[] nums) {
>           if( nums != null && nums.length < 0) {
>               return null;  
>           }else {
>               double ret = nums[0];
>               for(int i = 1; i < nums.length; i++) {
>                   if(nums[i] > ret) {
>                       ret = nums[i];
>                   }
>               }
>               return ret;
>           }
>       }
>   }
>
>2. 如何生成0、1、2的随机数
>
>   ```Java
>           Random random = new Random();
>           ret = random.nextInt(3);



#### IDEA快捷键

* alt + enter 自动导包
* ctrl + alt + L 代码格式化
* alr + R 快速运行代码
* ctrl + shift + Fn + F10 运行
* 右击 Generate Constructor
* Ctrl + H 查看层级关系
* .var 分配变量名
* Ctrl + B 找到方法位置
* Ctrl + D 删除行
* Ctrl + Alt + 向下光标 复制本行代码
* alt + / 补全代码
* ctrl + / 单行注释 

#### IDEA模板

* sout
* fori
* ifn
* inst
* itco
* iter
* iten

#### 