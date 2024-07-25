# PensionFund

A decentralized pension system.

China: On July 21, 2024, the Third Plenary Session of the 20th Central Committee of the Communist Party of China passed the "Decision of the Central Committee of the Communist Party of China on Further Comprehensively Deepening Reform and Promoting Chinese-style Modernization," which mentioned advancing the gradual delay of the statutory retirement age reform in a prudent and orderly manner according to the principles of voluntariness and flexibility. Several tasks were also deployed in the social security field. The Chinese Academy of Social Sciences released a report stating that the cumulative balance of the National Urban Employee Basic Pension Insurance Fund will be exhausted by 2035. Over the next 30 years, the dependency ratio of the system will double, and the pressure on pension payments will continue to increase. In 2019, nearly two contributors supported one retiree; by 2050, almost one contributor will need to support one retiree. China's economic downturn, aging population, and low fertility rate are leading to severe challenges in the pension system. According to a report by The Wall Street Journal on May 29, 2024, the Chinese Academy of Social Sciences, a top government think tank in China, estimates that the National Urban Employee Basic Pension Insurance Fund will be exhausted by 2035. The International Monetary Fund (IMF) also predicts that China's economy will remain sluggish or even worsen in the coming years, with economic downturns further impacting the pension system.

United States: The Social Security Amendments of 1983 gradually raised the full retirement age (FRA) from 65 to 67. Between 1935 and 2024, the contribution rates for employees and employers in the US pension system increased from 1% to 6.2%.

Germany: Germany's pension system has undergone several adjustments, mainly to address population aging and fiscal pressures. The Pension Insurance Reform Act of 2007 (Rentenversicherungs-Altersgrenzenanpassungsgesetz 2007) gradually raised the statutory retirement age from 65 to 67 for those born in 1964 and later. The contribution rate has increased from 9% each for employees and employers in 1957 to 18.6% each in 2024.

As ordinary citizens, we cannot control the contribution rates, the number of years of contributions, or the retirement age.

So, is there any benefit to participating in social insurance, such as getting more money than managing it ourselves?

Take China as an example. Suppose the following conditions: average monthly salary: 10,000 RMB, individual contribution rate: 8%, employer contribution rate: 16%, contribution period: 40 years, retirement age: 65, average life expectancy: 80 years, average monthly salary of employees in the previous year: 5,000 RMB, annual average return rate of individual accounts: 3%. If a resident normally participates in social insurance, and if he is an employee, he pays 800 RMB per month, and the employer pays 1,600 RMB per month; if he is self-employed, he needs to pay 2,400 RMB per month. After contributing to pension insurance for 40 years, the monthly pension he can receive after retirement is about 8,454.67 RMB. This amount will be adjusted based on the actual average monthly salary of employees, the personal account balance, and its returns.

What if the resident manages this part of the funds himself?

If he is self-employed and pays 2,400 RMB per month for pension insurance, he would have paid a total of 1,152,000 RMB. This is without considering compound interest. If calculated with 3% compound interest, by the time he retires at 65, his pension fund would accumulate to 2,226,000 RMB. Considering a 3% interest return on 2,226,000 RMB, he can withdraw all the money within 15 years, receiving about 15,366.67 RMB per month. Over 15 years, he would receive a total of 2,766,000 RMB.
If he is an employee in China and only considers his personal contribution of 800 RMB per month, he would have paid a total of 384,000 RMB in pension insurance. This is without considering compound interest. If calculated with 3% compound interest, by the time he retires at 65, his personal account would accumulate to 723,848 RMB. Considering a 3% interest return on 723,848 RMB, he can withdraw all the money within 15 years, receiving about 5,091 RMB per month. The total amount received would be 916,380 RMB.

This is still under the premise of not considering government default, delayed retirement age, other policy changes, unexpected early death, etc., and people cannot ensure whether they can receive the pension they have paid or how much they can receive.

Obviously, this is not a good deal. Managing it ourselves is significantly more profitable than giving it to the government or some centralized institutions. However, people do not generally manage their pensions themselves. The reasons may be numerous: it may require compulsion to prevent oneself from misusing this crucial pension money, one may not have the ability to manage the pension funds, or there may be a lack of trustworthy institutions to assist in managing the pension.

Blockchain might provide a new solution to this problem.

The core value of blockchain is decentralization, transparency, and trustless networks. Code is Law. All pension systems worldwide are regulated by centralized institutions such as governments or companies. In regions with unstable policies, young people may have significant concerns about whether they will receive the expected returns on their pension contributions.

Based on this idea, I wrote the PensionFund smart contract. Through blockchain, decentralized management of personal pensions can be achieved. Users have absolute control over the rules of their pensions, including contribution period, contribution cycle, contribution amount, withdrawal time, withdrawal period, payout wallet, and beneficiaries in case of unexpected situations. This removes significant instability from centralized institutions. To restrict the specific use of pension funds and prevent arbitrary withdrawals, while also ensuring that the funds can be withdrawn in extremely special circumstances, I have implemented a multi-signature system. Only when the number of people agreeing to use the pension funds reaches the set threshold can the funds be used; otherwise, they cannot be withdrawn. The same restriction applies to modifying key information such as expected retirement time and payout wallet address, which is only allowed when the threshold number of signatures is reached.

Future upgrade ideas: Select large-scale DeFi projects, call their interfaces to manage pensions, and ensure stable growth. The selected DeFi projects will be regularly adjusted, and the adjustment method can be determined through community voting. Issue tokens to users based on the amount of pension contributions. The number of tokens held can serve as credentials for DAO governance, such as voting rights for selecting DeFi interfaces.

The contract has been deployed and debugged on Sepolia, with the contract address at 0xcDA643aAd5ED482A4958B370a2Bf142a173Efe3d.

==================================================================================================

A decentralised pension system.

中国：2024 年 7 月 21 日，中国共产党第二十届中央委员会第三次全体会议通过的《中共中央关于进一步全面深化改革、推进中国式现代化的决定》公布，其中提到按照自愿、弹性原则，稳妥有序推进渐进式延迟法定退休年龄改革，并对社保领域多项工作作出部署。
中国社会科学院发布的报告说，全国城镇职工基本养老保险基金累计结余将于 2035 年耗尽。未来 30 年，制度赡养率翻倍，养老保险支付压力不断在提升。2019 年由接近两个缴费者来赡养一个退休人员，到了 2050 年，几乎一个缴费者需要赡养一名退休者。
中国经济低迷、人口老龄化和生育率低，导致养老金系统面临严峻挑战。美国《华尔街日报》2024 年 5 月 29 日的报道指，据中国顶级政府智库中国社科院估计，全国城镇职工基本养老保险基金将于 2035 年耗尽。国际货币基金组织（IMF）也预测，未来几年，中国经济将持续低迷甚至恶化，经济滑坡会进一步冲击养老金体系。

美国：
1983 年《社会保障修正案》（Social Security Amendments of 1983）全额退休年龄（Full Retirement Age, FRA）逐步从 65 岁提高到 67 岁。
1935 年至 2024 年间，美国养老金制度中雇员和雇主缴费额度从 1%调整到 6.2%。

德国：
德国养老金制度多次调整，主要是为了应对人口老龄化和财政压力。2007 年《养老金保险改革法》Rentenversicherungs-Altersgrenzenanpassungsgesetz 2007）将法定退休年龄从 65 岁逐步提高到 67 岁，适用于 1964 年及以后出生的人。
缴费比例由 1957 年的雇员和雇主各缴纳 9%，至 2024 年雇员和雇主各占工资的 18.6%。

作为普通公民，缴纳多少比例无法控制，缴纳多少年限无法控制，多少岁退休还是无法控制。

那么，参与社会保险，是否有收益上的好处呢，例如，比自己保管能拿到更多的钱？
以中国为例。假设条件：月均工资：10000 元，个人缴纳比例：8%，企业缴纳比例：16%，缴费年限：40 年，退休年龄：65 岁，平均寿命：80 岁，上年度在岗职工月平均工资：5000 元，个人账户的年平均收益率：3%。
居民正常参保，，如果他是企业职员，则个人每月缴纳 800 元，企业每月缴纳 1600 元；如果他是个自由职业者，则其个人每月需缴纳 2400 元。缴纳 40 年养老保险。退休后每个月能领取的养老金大约为 8454.67 元。这一金额会根据实际的职工月平均工资、个人账户储存额及其收益等因素有所调整。

那么如果居民自己管理此部分资金呢？
如果此人是个自由职业者，他每月个人缴纳养老金 2400 元，一共缴纳为 1152000 元。此为不考虑复利的情况下。如果按照 3%复利计算，截至其 65 岁退休，其缴纳 40 年期间共积累养老金 222.6 万元。如果考虑到 222.6 万元的 3%利息收益，想在 15 年内把这些钱全部领完，每个月可以领取约 15366.67 元。15 年间共领取 276.6 万元。
如果此人是一个生活在中国的公司职员，单纯考虑其个人缴纳养老金 800 元的情况，此人个人一共缴纳了 384000 元养老金。此为不考虑复利的情况下。如果按照 3%复利计算，截至其 65 岁退休，其缴纳 40 年期间个人账户共积累养老金 723,848 元。
如果考虑到 723,848 元的 3%利息收益，想在 15 年内把这些钱全部领完，每个月可以领取约 5091 元。总共领取金额为 916380 元。

这还是在不考虑政府失信、退休年龄延期、其他政策变化、意外提前死亡等等因素的前提下，人们无法确保缴纳的保险金能否领到、能领到多少。
这显然不是一笔合适的生意，自己操作明显比交给政府或某些中心化机构的收益高得多。
然而，人民却没有普遍对自己的养老金进行管理。原因可能有很多：可能需要强制才能让自己无法挪用这笔至关重要的养老的钱、可能自己并没有管理养老金的能力、可能缺乏可信任的机构协助管理养老金。

区块链或许可解提供一种新的解决问题的思路。

区块链的核心价值是去中心化、透明公开、去信任的网络。Code is Law。
全世界所有的养老金体系，都由政府或公司这种中心化机构制定规则和政策。在某些政策稳定性不强的地区，年轻人缴纳养老金是否能得到预期的回报是个比较大的问题。

按此思路，我写了 PensionFund 智能合约。通过区块链方式，实现去中心化的对于个人养老金的管理。而用户本人对于养老金的规则有绝对的控制权，包括缴费年限、缴费周期、缴费金额、领取时间、领取年限、领取钱包、意外情况受益人等等。不再受中心化机构的干扰，去除了很大的不稳定因素。为了限制养老金的专项用途，避免随意调用养老金，同时也避免极其特殊的情况下需要使用养老金账户内的钱而无法取出，我设置了多签签名制度。只有同意使用养老金的人数达到了设置好的门槛数量，我们才能调用此部分养老金，否则无法调用。同时，我们对修改关键信息，比如预期退休时间、领取养老金钱包地址等做了同样的限制，只有达到门槛数量的签名后才允许修改。
后期升级思路：选取规模较大的 defi 项目，调用接口，对养老金进行管理，确保稳定增值。选取的 defi 项目定期进行调整，调整方式可以通过社区投票的方式确定。根据缴纳养老金的金额，向用户发行 token。而持有的 token 数量可以作为 DAO 治理的凭证，例如，选取 DEFI 接口的投票权。

合约已经在 sepolia 部署并调试，合约地址 0xcDA643aAd5ED482A4958B370a2Bf142a173Efe3d。
