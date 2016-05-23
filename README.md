
![HZCoreMannger使用](https://mmbiz.qlogo.cn/mmbiz/wFa30ADx7kLyVibJ5VJwMYX2j04h3mOlPfKw9NloHhlZRM51wTbEQmEUOLibVDicicpIwShx2FNLWobIiajz0ulsTLw/0?wx_fmt=jpeg)

### HZCoreMannger
### 使用一句话调用工具类，对数据进行操作

## 1:类文件内容

```ruby
 1：在使用之前需要对 HZCoreMannger.m文件作出修改，

 修改两个宏定义
 // coredata 的数据库名称
 #define COREDATANAME @"IColud"
 // 创建DB的名称
 #define DBNAME @"IColud.sqlite"

```

## 2：HZCoreMannger.h
```ruby

     /**添加*/
     -(void)insertDataWithClassName:(NSString*)name attriDic:(NSDictionary*)dic;

    /**删除*/
    -(void)deleteDataWithClassName:(NSString*)name predicate:(NSPredicate*)predicate ;

    /**查询*/
    -(NSArray*)selectDataFromClassName:(NSString*)name predicate:(NSPredicate*)predicate sortkeys:(NSArray*)sortkeys;   

    /**
     *  根据谓词查询分页数据
     *
     *  @param name      表名
     *  @param predicate 谓词
     *  @param sortkeys  排序字段
     *  @param index     页码
     *  @param countData 每页数量
     *
     *  @return <#return value description#>
     */
    -(NSArray*)selectDataFromClassName:(NSString*)name predicate:(NSPredicate*)predicate sortkeys:(NSArray*)sortkeys fromIndex:(NSInteger)index rowCount:(NSInteger)countData;

    /**
     *  更新
     * 
     *  @param name      表名
     *  @param dic       <#dic description#>
     *  @param predicate <#predicate description#>
     */
    -(void)modifyDataWithClassName:(NSString*)name attriDic:(NSDictionary*)dic predicate:(NSPredicate *)predicate;


 ```   

## 3: 方法使用
 3.1 向数据库中添加(insert)
```ruby
    NSDictionary * dict = [[NSDictionary alloc] init];
    dict = @{@"invoceid":@"2001",@"kpf":@"京东",@"titles":@"测试公司"};
    [[HZCoreMannger defaultManager] insertDataWithClassName:@"Invoce" attriDic:dict];
```

 3.2 向数据库中删除(deleate)
```ruby
    // 如果没有谓词输入，就默认检索全部信息
    //NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2026"];
    [[HZCoreMannger defaultManager] deleteDataWithClassName:@"Invoce" predicate:nil];
```

 3.3 向数据库中更新(update)
```ruby
    NSDictionary * dict = [[NSDictionary alloc] init];
    dict = @{@"kpf":self.userName.text,@"titles":@"0000测试公司osJoin"};
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2026"];
    [[HZCoreMannger defaultManager] modifyDataWithClassName:@"Invoce" attriDic:dict predicate:predicate];
```
    
 3.4 向数据库中查询(select)
```ruby
    // 如果没有谓词输入，就默认检索全部信息
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@" invoceid = %@",@"2001"];
    NSArray * arry =  [[HZCoreMannger defaultManager]selectDataFromClassName:@"Invoce" predicate:predicate sortkeys:nil];
    // 遍历查找信息
    for (NSManagedObject *item in arry) {
        NSString *typeStr = [item valueForKey:@"titles"];
        NSLog(@"=============>>>>%@",typeStr);
    }
```
 3.4 向数据库中分页查询(select:fromIndex:rowCount)
```ruby
    // 如果没有谓词输入，就默认检索全部信息,这里的self.pageNumber就是你上拉刷新的页码计数咯
    NSArray * selectarry =  [[HZCoreMannger defaultManager] selectDataFromClassName:@"Invoce" predicate:predicate sortkeys:nil fromIndex:self.pageNumber rowCount:10];
    for (NSManagedObject *item in selectarry) {
        NSString *typeStr = [item valueForKey:@"titles"];
        NSLog(@"=============>>>>%@",typeStr);
    }
```
