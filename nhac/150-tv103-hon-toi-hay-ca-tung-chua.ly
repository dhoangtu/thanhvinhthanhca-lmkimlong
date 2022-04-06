% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Hồn Tôi Hãy Ca Tụng Chúa" }
  composer = "Tv. 103"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \autoPageBreaksOff
  \partial 8 c16 g' |
  g4 \tuplet 3/2 { f8 e d } |
  a'4 r8 g 
  e'4. b16 c |
  d4. c8 |
  g4. a16 g |
  f4. e8 |
  d4 r8 e16 c |
  c4. c8 |
  g' g4 a16 (g) |
  e4 \tuplet 3/2 { f8 d d } |
  a'4. a8 |
  g d'4 b8 |
  \stemDown c2 ~ |
  c4 r8 \bar "||" \break
  \stemNeutral
  
  c,16 c |
  f8. d16 \tuplet 3/2 { g8 g e } |
  a4 r8 b16 a |
  
  \pageBreak
  
  g8. g16 \tuplet 3/2 { c8 e d } |
  d2 ~ |
  d4 \tuplet 3/2 { b8 d c } |
  %\pageBreak
  c8. e,16 \tuplet 3/2 { g8 g a } |
  a4 r8 a16 g |
  
  \pageBreak
  
  f8 e d g |
  c,2 ~ |
  c4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  c16 g' |
  g4 \tuplet 3/2 { f8 e d } |
  a'4 r8 g |
  c4. g16 e |
  f4. f8 |
  e4. f16 e |
  d4. c8 |
  b4 r8 e16 c |
  c4. c8 |
  e e4 d8 |
  c4 \tuplet 3/2 { f8 d d } |
  a'4. f8 |
  e f4 g8 |
  <e c>2 ~ |
  <e c>4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Hồn tôi ơi, hãy ca tụng Chúa,
  lạy Chúa là Thiên Chúa con thờ,
  Chúa cao cả muôn trùng,
  Áo Ngài mặc toàn oai phong lẫm liệt,
  Cẩm bao Ngài khoác muôn vạn ánh hào quang.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Tầng trời thẳm Ngài căng như màn trướng
      Với cung điện dựng trên nước mênh mông
      Ngự giá xe mây, Ngài tung bay cánh gió
      Bắt muôn ngọn lửa làm nô bộc.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Địa cầu đó Ngài xây trên nền vững
	    Đến muôn đời hằng kiên cố khôn lay
	    Vực thẳm mênh mông choàng lên thân trái đất
	    Nước quy tụ trên đỉnh núi đồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Lời Ngài mới vừa âm vang truyền phán
	    Chúng kinh hoàng chạy tan tác nơi nơi
	    Vượt núi non cao, tràn nương xanh bát ngát
	    Tưới cây cỏ xanh rì lá cành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Kìa Ngài khiến khởi nguyên bao mạch suối
	    Giữa núi đồi lượn muôn khúc quanh co
	    Cầm thú no say, ngựa hoang nay đã khát,
	    Lũ chim rủ nhau về kết đoàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Từ trời thẳm đổ mưa trên đồi núi
	    Đó ân lộc Ngài gieo xuống dương gian
	    Cỏ thắm nương xanh để nuôi gia súc béo,
	    Sẵn rau để con người hưởng dùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Từ ruộng đất tìm ra ngay được bánh
	    Phấn khởi vì rượu pha chế thơm ngon
	    Dầu ngát hương bay làm duyên tươi sắc thắm,
	    Bánh cơm để no lòng chắc dạ.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Nhờ Ngài khiến ngàn cây căng nhựa sống
	    Chúa vun trồng cả hương bá Ly -- băng
	    Từng cánh chim bay về đây xây mái ấm,
	    Núi cao thẳm muôn loài ẩn mình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài trần thiết vầng trăng đo thời tiết
	    Đúng theo giờ, vầng ô gác non tây
	    Vào lúc đêm lên Ngài tung gieo bóng tối,
	    Tiếng sư tử vang dội núi rừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Ngày vừa tới là bao nhiêu cầm thú
	    Bảo nhau về tìm hang hốc nương thân
	    Là lúc nhân gian cùng ra lao tác hết
	    Những mê mải cho tận đến chiều.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "10."
      \override Lyrics.LyricText.font-shape = #'italic
	    Sự việc Chúa thực thiên muôn hình sắc
	    Đã viên thành thể theo đức khôn ngoan
	    Biển nước mênh mông, tàu ra khơi lướt sóng,
	    Các sinh vật to nhỏ vẫy vùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "11."
	    Mọi loài vẫn bền tâm trông về Chúa,
	    Những trông đợi Ngài theo bữa nuôi ăn
	    Ngài mới quay đi mọi sinh linh khiếp hãi,
	    Rút hơi thở chúng thành cát bụi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "12."
      \override Lyrics.LyricText.font-shape = #'italic
	    Này Thần Khí Ngài ban cho trần thế,
	    Khiến địa cầu được đổi mới xinh tươi
	    Thần khí cao minh tạo sinh ra thế giới,
	    Cánh tay mở ban lộc phúc đầy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "13."
	    Sự nghiệp Chúa ngàn muôn năm còn mãi
	    Những sự nghiệp làm cho Chúa hân hoan
	    Kìa đất run lên vừa khi ra mắt Chúa,
	    Núi bung lửa khi Ngài khẽ đụng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "14."
      \override Lyrics.LyricText.font-shape = #'italic
	    Trọn cuộc sống nguyện luôn ca mừng Chúa
	    Tấu cung đàn ngợi khen mãi khôn ngơi
	    Nguyện tiếng con đây làm vui say thánh ý,
	    Mối hoan hỷ con là chính Ngài.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
  ragged-bottom = ##t
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
