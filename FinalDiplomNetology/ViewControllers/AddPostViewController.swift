//
//  AddPostViewController.swift
//  FinalDiplomNetology
//
//  Created by Shalopay on 06.02.2023.
//

import UIKit

class AddPostViewController: UIViewController {
    weak var delegate: ProfileDelegateUpdateTableView?
    var coreDataManager = CoreDataManager.shared
    var user: User?
    var selectImage: Data?
    
    private lazy var postTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.delegate = self
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "Что у вас нового?"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont(name: "rubik-regular", size: 16)
        textView.inputAccessoryView = toolBar
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var cancelImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(deleteSelectedImage), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var selectImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: .zero)
        toolBar.sizeToFit()
        let addImageButton = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(addImageToolBar))
        addImageButton.tintColor = UIColor(hexRGB: ColorType.LabelTextColor.textBlackColor.rawValue)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([addImageButton ,spaceButton], animated: true)
        return toolBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        postTextView.resignFirstResponder()
    }
    
    @objc private func addImageToolBar(){
        print(#function)
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func deleteSelectedImage() {
        print(#function)
        selectImageView.isHidden = true
        cancelImageButton.isHidden = true
    }
    
    private func setupView() {
        createNavigationController(isHidden: false)
        view.addSubviews([postTextView, selectImageView, cancelImageButton])
//        selectImageView.addSubview(cancelImageButton)
        title = "Создание поста"
        let sendBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .done, target: self, action: #selector(sendAction))
        let cancelBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "clear.fill"), style: .done, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItems = [cancelBarButtonItem]
        navigationItem.rightBarButtonItems = [sendBarButtonItem]
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            postTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            postTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),

            
            cancelImageButton.trailingAnchor.constraint(equalTo: selectImageView.trailingAnchor, constant: -5),
            cancelImageButton.topAnchor.constraint(equalTo: selectImageView.topAnchor, constant: 5),
            cancelImageButton.heightAnchor.constraint(equalToConstant: 20),
            cancelImageButton.widthAnchor.constraint(equalToConstant: 20),
            
            selectImageView.topAnchor.constraint(equalTo: postTextView.bottomAnchor, constant: 10),
            selectImageView.heightAnchor.constraint(equalToConstant: 100),
            selectImageView.widthAnchor.constraint(equalToConstant: 100),
            selectImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            selectImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func sendAction() {
        print(#function)
        guard let textPost = postTextView.text else {return}
        let post = coreDataManager.createPost(image: selectImage, text: textPost)
        user?.addToPosts(post)
        delegate?.updateTableView()
        dismiss(animated: true, completion: nil)
    }
    @objc private func cancelAction() {
        print(#function)
     dismiss(animated: true, completion: nil)
    }
}

extension AddPostViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
            if updatedText.isEmpty {
                textView.text = "Что у вас нового?"
                textView.textColor = UIColor.lightGray
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
             else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.textColor = UIColor.black
                textView.text = text
                textView.font = UIFont(name: "rubik-regular", size: 16)
            }
            else {
                return true
            }
            return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else {return}
        
        DispatchQueue.main.async {
            self.selectImage = image.jpegData(compressionQuality: 1)
            guard let imageData = self.selectImage else {return}
            self.selectImageView.image = UIImage(data: imageData)
        }
        picker.dismiss(animated: true) {
            self.selectImageView.isHidden = false
            self.cancelImageButton.isHidden = false
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
