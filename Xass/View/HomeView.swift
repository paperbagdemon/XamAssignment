//
//  HomeView.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State var isShowingAlert = false
    @State var alertMessage = ""
    @State var alertTitle = ""
    @State var isImagePickerShown = false
    @State var isProgressViewVisible = false
    var body: some View {
        ScrollView {
            VStack {
                HStack() {
                    Image(systemName: "mappin")
                    Text("Martin Pulgar Construction")
                    Text("|")
                    Text(viewModel.currentLocation)
                    Spacer()
                }
                .padding(20)
                .background(Color.white)
                .onTapGesture {
                    viewModel.fetchCoordinates()
                }
                HStack() {
                    Text("Add to site diary")
                        .font(.title)
                    Spacer()
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.gray)
                }.padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 20))
                VStack(alignment: .leading, spacing: 20) {
                    photosSection
                    commentsSection
                    detailsSection
                    eventSection
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 0, trailing: 20))
                .background(Color.XassBackgroundColor)
                HStack {
                    Button {
                        isProgressViewVisible = true
                        viewModel.submitDiary()?.sink(receiveCompletion: { error in
                            isProgressViewVisible = false
                            switch error {
                            case .failure(let error):
                                alertTitle = "Error"
                                alertMessage = error.localizedDescription
                                isShowingAlert = true
                            case .finished: ()
                            }

                        }, receiveValue: { response in
                            alertTitle = "Success"
                            alertMessage = "Log has been submitted"
                            isShowingAlert = true
                        }).store(in: &viewModel.bag)
                    } label: {
                        Text("Next")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(14)
                    .background(Color.green)
                    .cornerRadius(5)
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
            }.alert( isPresented: $isShowingAlert, content: {
                Alert(title: Text(alertTitle),
                     message: Text(alertMessage))
            })
        }
        .overlay(progressOverlay)
        .background(Color.XassBackgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            viewModel.loadTestData()
        }

    }
    
    @ViewBuilder
    var progressOverlay: some View {
        if isProgressViewVisible {
            ProgressView()
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var photosSection: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Add Photos to site diary")
                    .font(.headline)
                Spacer()
            }.padding(8)
            Divider()
            PhotoScroll(items: $viewModel.photos)
            HStack {
                Button {
                    isImagePickerShown = true
                } label: {
                    Text("Add a Photo")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(14)
                .background(Color.green)
                .cornerRadius(5)
            }.padding(8)
            HStack {
                Text("Include in photo gallery")
                    .font(.footnote)
                Spacer()
                CheckBox(isChecked: $viewModel.shouldIncludeInGallery)
                    .frame(width: 25, height: 25)
            }.padding(EdgeInsets(top: 0, leading: 12, bottom: 8, trailing: 12))
        }
        .sheet(isPresented: $isImagePickerShown) {
            ImagePicker(sourceType: .photoLibrary) { image in
                viewModel.photos.append(PhotoScrollItem(image: image))
                isImagePickerShown = false
            }
        }
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .shadow(color: .gray, radius: 5, x: 0, y: 2))
        
    }
    
    @ViewBuilder
    var commentsSection: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Comments")
                    .font(.headline)
                Spacer()
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
            Divider()
            HStack {
                TextEditor(text: $viewModel.comments)
                    .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
                    .padding(14)
                    .overlay(Underline())
            }.padding(8)
        }
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .shadow(color: .gray, radius: 5, x: 0, y: 2))
    }
    
    @ViewBuilder
    var detailsSection: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Details")
                    .font(.headline)
                Spacer()
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
            Divider()
            VStack {
                SelectionField<DateSelection>(placeholder: "Select Date", selections: [Date()]) { selected in
                    guard let selected = selected as? Date else {
                        return
                    }
                    viewModel.date = selected
                }
                SelectionField<TableSelection>(placeholder: "Select Area", title: "Select an area", selections: viewModel.selectionAreas) { selected in
                    guard let selected = selected as? String else {
                        return
                    }
                    viewModel.area = selected
                }
                SelectionField<TableSelection>(placeholder: "Task Category", title: "Select a category", selections: viewModel.selectionCategories) { selected in
                    guard let selected = selected as? String else {
                        return
                    }
                    viewModel.category = selected
                }
                SelectionField<TableSelection>(placeholder: "Tags", title: "Select a tag", selections: viewModel.selectionTags) { selected in
                    guard let selected = selected as? String else {
                        return
                    }
                    viewModel.tags = [selected]
                }
            }.padding(8)
        }
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .shadow(color: .gray, radius: 5, x: 0, y: 2))
    }
    
    @ViewBuilder
    var eventSection: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Link to existing event?")
                    .font(.headline)
                Spacer()
                CheckBox(isChecked: $viewModel.shouldLinkToEvent)
                .frame(width: 25, height: 25)
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
            Divider()
            VStack {
                SelectionField<TableSelection>(placeholder: "Select an event", title: "Select an event", selections: viewModel.selectionEvents, onSelect: { selected in
                    guard let selected = selected as? String else {
                        return
                    }
                    viewModel.event = selected
                })
                    .disabled(!viewModel.shouldLinkToEvent)
            }.padding(8)
        }
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(Color.white)
            .shadow(color: .gray, radius: 5, x: 0, y: 2))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
