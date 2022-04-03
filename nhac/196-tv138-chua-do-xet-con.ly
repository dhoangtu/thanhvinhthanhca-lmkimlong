% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúa Dò Xét Con" }
  composer = "Tv. 138"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \autoPageBreaksOff
  \partial 8 c8 |
  c (a16 g) f8 a |
  g4. d8 |
  g g e (d) |
  c4 r8 c'16 bf |
  bf8 bf c bf |
  g4 r8 e16 g |
  c,8 c g'16 g e8 |
  f4 r8 \bar "||" \break
  
  f16 f |
  d8 c a' f |
  g8. g16 bf8 bf |
  c2 |
  bf8 d g, bf |
  c8. c16 a (g) f8 |
  g4 r8 d |
  
  \pageBreak
  
  g4. e8 |
  e g e16 (d) c8 |
  d4 r8 d |
  a'4. a8 |
  g c a16 (g) f8 |
  f4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  %\set stanza = "ĐK:"
  Chúa đã xét dò con,
  và Chúa biết ngọn nguồn.
  Chúa biết con khi đứng khi ngồi,
  Con nghĩ gì Ngài thấu suốt từ xa.
  <<
    {
      \set stanza = "1."
      Khi đi lại hoặc lúc nghỉ ngơi
      Ngài luôn xem xét.
      Mọi lối đường con đi Chúa đâu lạ chi
      Lời con khi chưa thốt ra cửa môi
      Thì Chúa đã từ trước am tường rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Luôn bao bọc và giữ gìn con
	    toàn thân sau trước,
	    Ngài vẫn đặt tay lên mãi trên mình con,
	    Thần Trí cao siêu Chúa diệu kỳ thay,
	    Hèn kém con hiểu thấu sao tận tường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Đi nơi nào Thần Trí Ngài không từng giây theo dõi,
	    Và biết tìm nơi đâu khuất xa Thần Nhan
	    Dù lên thiên cung, Chúa đang ngự đây,
	    Dù xuống địa ngục vẫn luôn gặp Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chắp cánh bay từ phía hừng đôgn hiện lên le lói
	    Tìm đến tận chân mây góc biển trời tây,
	    Tại đây đôi tay Chúa cũng dìu đưa,
	    Mạnh mẽ tay Ngài giữ con nào rời.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Con mong thầm:
	    màn tối phải chi phủ che con mãi,
	    Sự sáng ở quanh con bỗng trở thành đêm,
	    Mà Chúa coi đêm sáng như ngày thôi,
	    Màn tối cũng nào có chi mịt mù.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Thân con này Ngài đã dệt nên từ trong thân mẫu,
	    Cả đến tạng phủ con Chúa cũng tạo nên,
	    Này con ca khen biết bao kỳ công
	    Mà Chúa đã làm khiến con được tường.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Xương con này Ngài có lạ chi dù luôn che kín,
	    Ngài biết từ âm ty lúc thêu dệt nên,
	    Từ trong thai nhi Chúa đã nhìn xem
	    Ngày tháng trên đời Chúa ghi định rồi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ôi tư tưởng Ngài bí nhiệm thay,
	    huyền vi khôn xiết,
	    Nhiều quá chứng đi thôi đếm sao nổi đây,
	    Nhiều hơn trăm muôn cát biển mọi nơi
	    Tỉnh giấc con lại vẫn luôn gặp Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "9."
	    Chúa xét dò và cõi lòng con Ngài nay thông suốt,
	    Ngài thử luyện con nên rõ tâm tưởng con,
	    Ngài xem như con bước theo tà gian
	    Thì kíp dẫn về chính lộ ngàn đời.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 10\mm
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
  %page-count = #1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
    \override Lyrics.LyricSpace.minimum-distance = #1.2
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
