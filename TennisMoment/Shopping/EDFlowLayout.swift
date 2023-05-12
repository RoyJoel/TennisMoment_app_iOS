//
//  EDFlowLayout.swift
//  EDMS
//
//  Created by Jason Zhang on 2023/4/21.
//

import Foundation
import UIKit

class TMFlowLayout: UICollectionViewFlowLayout {
    //    封装一个属性，用来设置item的个数
    let itemCount: Int
    //    添加一个数组属性，用来存放每个item的布局信息
    var attributeArray: [UICollectionViewLayoutAttributes]?
    //    实现必要的构造方法
    required init?(coder aDecoder: NSCoder) {
        itemCount = 0
        super.init(coder: aDecoder)
    }

    //    自定义一个初始化构造方法
    init(itemCount: Int) {
        self.itemCount = itemCount
        super.init()
    }

    override func prepare() {
        // 调用父类的准备方法
        super.prepare()
        // 初始化数组
        attributeArray = [UICollectionViewLayoutAttributes]()
        // 先计算每个item的宽度，默认为两列布局
        let WIDTH = (UIScreen.main.bounds.size.width - minimumInteritemSpacing) / 2 - 24
        // 定义一个元组表示每一列的动态高度
        var queueHieght: (one: CGFloat, two: CGFloat) = (0, 0)
        // 进行循环设置
        for index in 0 ..< itemCount {
            // 设置IndexPath，默认为一个分区
            let indexPath = IndexPath(item: index, section: 0)
            // 创建布局属性类
            let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 随机一个高度在80到190之间的值
            let height = WIDTH * calculateAR(image: UIImage(named: com[index].images[0]) ?? UIImage()) + 100
            // 哪列高度小就把它放那列下面
            // 标记那一列
            var queue = 0
            if queueHieght.one <= queueHieght.two {
                queueHieght.one += (height + minimumInteritemSpacing)
                queue = 0
            } else {
                queueHieght.two += (height + minimumInteritemSpacing)
                queue = 1
            }
            // 设置item的位置
            let tmpH = queue == 0 ? queueHieght.one - height : queueHieght.two - height
            attris.frame = CGRect(x: (minimumInteritemSpacing + WIDTH) * CGFloat(queue), y: CGFloat(tmpH), width: WIDTH, height: CGFloat(height))
            // 添加到数组中
            attributeArray?.append(attris)
        }
        // 以最大一列的高度计算每个item高度的中间值，这样可以保证滑动范围的正确
        if queueHieght.one <= queueHieght.two {
            itemSize = CGSize(width: WIDTH, height: queueHieght.two * 2.0 / CGFloat(itemCount) - minimumLineSpacing)
        } else {
            itemSize = CGSize(width: WIDTH, height: queueHieght.one * 2.0 / CGFloat(itemCount) - minimumLineSpacing)
        }
    }

    func calculateAR(image: UIImage) -> CGFloat {
        let width = image.size.width
        let height = image.size.height
        return height / width
    }

    // 将设置好存放每个item的布局信息返回
    override func layoutAttributesForElements(in _: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
}
