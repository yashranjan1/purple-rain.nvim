import { useEffect, useState } from "react";
import store, { decreaseQuantity, removeItem, setQuantityZero } from "../../store";
import { increaseQuantity } from "../../store";
import { useSnapshot } from "valtio"
import { AnimatePresence, motion } from "framer-motion";

const Cart = () => {

    const snap = useSnapshot(store)

    const [price, setPrice] = useState(0)

    useEffect(() => {
        
        let subtotal = 0
        snap.cartItems.forEach((item) => {
            subtotal += (parseFloat(item.price.replaceAll(',', '')) * item.quantity)
        })
        setPrice(subtotal)
    }, snap.cartItems)

    const [count, setCount] = useState(snap.cartItems.length)

    return (
        <>
            <div className="md:ml-28 md:mr-[72px] md:my-14 m-10">
                <h1 className="text-white font-montserrat font-bold text-5xl mb-8">Your Items</h1>
                <AnimatePresence>
                    {count == 0 && <motion.div
                        initiPal={{
                            opacity: 0,
                            y: 100
                        }}
                        animate={{
                            opacity: 1,
                            y: 0
                        }}
                        transition={{
                            duration: "1",
                            delay: "0.3"
                        }}
                        key="no-items-text"
                        className="absolute"
                    >
                        <h1 className="text-white font-montserrat font-thin text-5xl mb-8">You have no items, add some items and come back here!</h1>
                    </motion.div>}
                </AnimatePresence>
                <div className="flex flex-wrap xl:flex-nowrap w-full font-montserrat">
                    <div className="flex flex-wrap w-full xl:w-7/12">
                        <AnimatePresence>
                            {count > 0 && <motion.div className="w-full"
                                key="hr-exit"
                                exit={{
                                    x: -1000,
                                    opacity: 0
                                }}
                                transition={{
                                    duration: "0.4"
                                }}>
                                <hr className="mb-9 w-full" />
                            </motion.div>}
                        </AnimatePresence>
                        {snap.cartItems.map((item) => {
                            return (
                                <AnimatePresence key={item.id}>
                                    {item.quantity && <motion.div
                                        className="flex flex-col grow w-full"
                                        exit={{
                                            x: -1000,
                                            opacity: 0
                                        }}
                                        transition={{
                                            duration: "0.4"
                                        }}
                                        key={`item-${item.id}`}
                                    >
                                        <div className="flex grow w-full">
                                            <div className="grow-0">
                                                <img src={`../src/assets/${item.itemImage}`} className="max-w-36 md:max-w-xs rounded-xl " />
                                            </div>
                                            <div className="ml-8 grow w-full">
                                                <h1 className="md:text-2xl text-lg font-thin tracking-tight mb-5 text-white font-mono">{item.itemName}</h1>
                                                <p className="text-white md:mb-3">&#x20b9; {item.price}</p>
                                                <div className="relative flex items-center flex-wrap">
                                                    <p className="mr-4 text-white mt-5 md:mt-0">Quantity:</p>
                                                    <div className="flex">
                                                        <button type="button" className="bg-theme-color rounded-s-lg p-3 h-11 border-2 border-r-0 border-slate-800 active:bg-slate-800/40" onClick={() => decreaseQuantity(item)}>
                                                            <svg className="w-3 h-3 text-white" viewBox="0 0 18 2">
                                                                <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M1 1h16" />
                                                            </svg>
                                                        </button>
                                                        <div className="text-white py-[8px] w-14 text-center border-2 border-slate-800 bg-theme-color" id={`quantity-div-${item.id}`}>
                                                            {item.quantity}
                                                        </div>
                                                        <button type="button" className="bg-theme-color rounded-e-lg p-3 h-11 border-2 border-l-0 border-slate-800 active:bg-slate-800/40 " onClick={() => increaseQuantity(item)}>
                                                            <svg className="w-3 h-3 text-gray-900 dark:text-white" viewBox="0 0 18 18">
                                                                <path stroke="currentColor" strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 1v16M1 9h16" />
                                                            </svg>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div className="mr-5">
                                                <button onClick={() => {
                                                    setQuantityZero(item)
                                                    setCount(count - 1)
                                                    setTimeout(() => {
                                                        removeItem(item)
                                                    }, 200)
                                                }}>
                                                    <span className="material-symbols-outlined text-white" >close</span>
                                                </button>
                                            </div>
                                        </div>
                                        <div className="flex w-full">
                                            <hr className="my-9 w-full" />
                                        </div>
                                    </motion.div>}
                                </AnimatePresence>
                            )
                        })}
                    </div>
                    <div className="xl:w-4/12 xl:ml-20 w-full">
                        <AnimatePresence>
                            {count > 0 && <motion.div
                                className="w-full bg-theme-color border-[1.5px] rounded-lg border-white pt-9 px-9"
                                exit={{
                                    opacity: 0
                                }}
                                transition={{
                                    duration: "0.5"
                                }}
                                key="order-summ"
                            >
                                <p className="text-white font-semibold text-lg pb-3">Order Summary</p>
                                <div className="py-5 flex">
                                    <div className="text-white text-md">Sub-total</div>
                                    <div className="text-white text-md text-right grow mr-3">&#x20b9; {price}</div>
                                </div>
                                <hr className="w-full" />
                                <div className="py-5 flex">
                                    <div className="text-white text-md">Shipping</div>
                                    <div className="text-white text-md text-right grow mr-3">&#x20b9; 500</div>
                                </div>
                                <hr className="w-full" />
                                <div className="py-5 flex">
                                    <div className="text-white text-md">VAT (10%)</div>
                                    <div className="text-white text-md text-right grow mr-3">&#x20b9; {0.1 * price}</div>
                                </div>
                                <hr className="w-full" />
                                <div className="py-5 flex mb-3">
                                    <div className="text-white font-semibold text-lg">Order total</div>
                                    <div className="text-white font-semibold text-lg text-right grow mr-3">&#x20b9; {parseFloat(1.1 * price + 500).toFixed(2)}</div>
                                </div>
                            </motion.div>}
                        </AnimatePresence>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Cart;
